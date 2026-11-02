Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA960A5BE2
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=hKTQke3g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EAD10E04C;
	Mon,  2 Nov 2026 11:28:27 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA6910E04C
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:28:21 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 387CEBE;
 Mon,  2 Nov 2026 12:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793618763;
 bh=jVlSgTI/aCwhIEJiTK3f6g78ldwsCruOjjKeNYHsaAA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hKTQke3gMm1I9i1olKx7yx6xPZ9A3GePN70oCW8zyycKT3Zb6bWEvWpIZmouVYNrm
 gWJb2bqIpxk5e0PYa0S4MpcNtN2vr2Xe8c1TbrOj0dsgqVKn4Gn2wIsHWGKMCkZOa1
 4lxrUAN0kVkI+IlIMiPiqyObMS2xBmR9vCcH9P8w=
Message-ID: <f96d2a22-5916-4aa9-b2e1-9a5ebd78c5c3@ideasonboard.com>
Date: Mon, 2 Nov 2026 13:28:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] gpu: drm: omapdrm: call cec_s_phys_addr only if
 EDID is present
To: Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <d58e8dbe49a0af87e2e98463d620e33a8115c109.1793615824.git.hverkuil+cisco@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <d58e8dbe49a0af87e2e98463d620e33a8115c109.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 02/11/2026 12:36, Hans Verkuil wrote:
> If an EDID is present, then call cec_s_phys_addr. If not, then
> call cec_phys_addr_invalidate. This helps the CEC framework differentiate
> between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an EDID without
> a Physical Address.
> 
> This driver is one of the few that was doing this inconsistently.
> 
> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/omapdrm/dss/hdmi4.c     | 7 +++----
>   drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c | 5 +++++
>   drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h | 5 +++++
>   3 files changed, 13 insertions(+), 4 deletions(-)
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

