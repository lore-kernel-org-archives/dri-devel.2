Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592A6076C30
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnne1OJ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE7310EC9B;
	Sun,  8 Nov 2026 20:24:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A164510ECD0
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 20:23:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7125343ECC;
 Sun,  8 Nov 2026 20:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523781F008BF;
 Sun,  8 Nov 2026 20:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794169433;
 bh=qBaFjQFLcBBSS0/yQ9Bg9k/67NFL5hQgBHEWS8yf9kI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mnne1OJ+viWuJ6aHQAjROXw5814T7pS5sGtHwzXTTzw4CtTQOTjZB09A/MrlGZdAB
 w9aHipCeUHb5sIBvOKvvIw3lKyk/HZUVL9Lv+OMU9M/suEsl0cuL+wjT2lX8c0dI9Z
 OpSLOiy5JcihLkbanYf7K/g0r/XK3vhWe1fMrkCvhhQGuEh3MWzRMsTz7YljPxusze
 fr/ymr/REBAAZRdWSVKW75U8wpzaNYgTn4ZS+sYzvb3SgBSMjIeaDcHT3bBXxJzHFS
 ORNPRtpAiHX5Hn5f1ayn2E4ejAAOFBZqhVcIUQST+dXfx7FSDHvl58vP7RiTfqLoj1
 Y/wzF7meWE64w==
From: Bjorn Andersson <andersson@kernel.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>, Luca Weiss <luca@lucaweiss.eu>,
 Federico Amedeo Izzo <federico@izzo.pro>
Subject: Re: (subset) [PATCH 0/3] Support for the Samsung Galaxy Book2 Go
 (SC7280)
Date: Sun,  8 Nov 2026 14:20:33 -0600
Message-ID: <179416929372.628393.6400266306544455392.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 12 Oct 2026 20:11:02 +0200, Luca Weiss wrote:
> Add basic support for the Samsung Galaxy Book2 Go laptop. Basic support
> is just eDP panel support, devicetree bindings and a devicetree.

Applied, thanks!

[2/3] dt-bindings: arm: qcom: Add Samsung Galaxy Book2 Go
      commit: ac299104cdfbac5b0fa2846eff77192d804c60ef

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
