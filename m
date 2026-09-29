Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C8BCA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D57610F03B;
	Tue, 29 Sep 2026 18:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SIHKfoEv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD38F10F039;
 Tue, 29 Sep 2026 18:51:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5166860261;
 Tue, 29 Sep 2026 18:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1BC1F00898;
 Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707882;
 bh=qPNs7Rgi+Iv3ryAPWPYU9WVflP8sBYe+8hX6x7y4Bo8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SIHKfoEvzuctZnvv9mDmYJc0pCuYcsAe2Ht2WOOohi8uqg3n0XbHXKmWMLp3drukx
 UhQ8pXixl2GFHMVdMrCjl0X0L/rlc/KFtJP0e9V9LXpTF3ShqK+h58Ve9VTjJj2M3M
 6vkpQGTnrzlY0xsAWICEKq7LsumTU9LHaWyzozbzFOXteWRo8o8bS4mhR37uL2YbiQ
 eMZnI0g5x1cxvktvllb+x7FAHL61elLMzweaLNHK8BSKwzpb4bdqAJCRMTRjI3bijE
 vbV6gAJbamEU0kmexn5ftc3p5ftQsb+ZHBPAs5GGbyLs743nCm1EyqkTWeKnG5QOtR
 JF5R0N23WWzfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 6.6.y] drm/i915/hdcp: Add encoder check in
 intel_hdcp_get_capability
Date: Tue, 29 Sep 2026 14:50:55 -0400
Message-ID: <2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031728.88004-1-artem@trailofbits.com>
References: <20260929031728.88004-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

>  bool intel_hdcp_capable(struct intel_connector *connector)
>  {
> -	struct intel_digital_port *dig_port = intel_attached_dig_port(connector);
> +	struct intel_digital_port *dig_port;
[...]
> +	if (!intel_attached_encoder(connector))
> +		return capable;

On 6.6 this doesn't stop the oops. The debugfs intel_hdcp_info() calls
intel_hdcp2_capable() right after intel_hdcp_capable(), and
intel_hdcp2_capable() still starts with intel_attached_dig_port(connector)
without an encoder check, so the NULL deref just moves one call later.

Upstream fixed that half in d34f4f058edf ("drm/i915/hdcp: Add encoder
check in hdcp2_get_capability"), CVE-2024-53050. Its CVE record says the
bug arrived in 6.7, but 130849f8ec14 ("drm/i915/hdcp: Use intel_connector
as argument for hdcp_2_2_capable") only moved the deref into the DP/HDMI
shims. 6.6 still has it in intel_hdcp2_capable() itself.

Could you resend this as a 2-patch 6.6.y series: this backport plus a 6.6
adaptation of the hdcp2 fix that guards intel_hdcp2_capable()?

-- 
Thanks,
Sasha
