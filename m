Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0CCC5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703DB10E2ED;
	Sun, 16 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=rolf.reintjes@web.de header.b="k9fVUITh";
	dkim-atps=neutral
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Fri, 14 Aug 2026 17:31:13 UTC
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB9F10E193;
 Fri, 14 Aug 2026 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786728671; x=1787333471; i=rolf.reintjes@web.de;
 bh=HZfrFrp4Xh3qfnqAfbbtrpd8rhg+OszvgrsGxINTyYU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k9fVUIThTJpxoDJsH5uOljMNWAzYu2LaBz5dTDNLIkteYAFVjZ/CFz1ozEGkzTus
 Y7ZfaJrWMOL00onhSCvl9N8nqtBcci8jnXEfnX7otlmD1HrpLDldgSpjxsnJygJBI
 Ifa2BGLNyhPTlVxMPqvN15BVOuK+LFWo7ifb4btQAUYLt0hy5AOq6kOqpcUjYojFc
 91lyHFsraluOuFrg0Jk6IYC97kwsJPWxCHCBl1cy0JaNdV93/cnPhagxgq8wS3Bk4
 Jg1fPqXkjSmgSf0oEIyIpHL2wi8+AMuBg47yZYwO/Yp8+buaewdK4qdJRHFB3Bxpa
 CuGBWGCPeTvZ4trfyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1wYsZC2dW4-00UkzO; Fri, 14
 Aug 2026 19:25:50 +0200
Message-ID: <3ec52129-0629-46cb-a0d9-cc4dc68a502a@web.de>
Date: Fri, 14 Aug 2026 19:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "optmization"
 -> "optimization"
To: Colin Ian King <colin.i.king@gmail.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org
References: <20260814171335.1099999-1-colin.i.king@gmail.com>
From: Rolf Reintjes <rolf.reintjes@web.de>
In-Reply-To: <20260814171335.1099999-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H2qIpYqvGcZXYQIzcQNEoGgLjczrAJwd+R/fORj6YsJsOQpQy7T
 zKTSnovgPyTa0pYNPMLs9HwqEmzvgereTxhMwBTnhNGMzKOIe+bxUDulcczOKCMc8caaQgd
 AFc95gmjeVVorwXTIEdJOtuY6NArtoz285Dq4UgVxMdb1si01y4nLiRqNvpkSsJVHmpMp4g
 mXEbxnTXklT6AQGDJ0Qbg==
UI-OutboundReport: notjunk:1;M01:P0:Ja2hk+EG5jA=;6zRPr2YjhEnsmJf5ZYLhOzdOGY7
 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
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Hello,

Am 14.08.2026 um 19:13 schrieb Colin Ian King:
> There is a spelling mistake in a DML_ASSERT_MSG message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   .../drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dm=
l2_top_utm.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dm=
l2_top_utm.c
> index ab9cadaf5a60..79ec5838c26f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_=
utm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_=
utm.c
> @@ -123,7 +123,7 @@ static enum dml2_status dml2_top_perform_stage_optim=
ization(struct dml2_instance
>   	DML_ASSERT_MSG(worksheet->validation_result.is_mode_support_valid
>   			&& worksheet->validation_result.is_mcache_allocation_valid
>   			&& worksheet->validation_result.is_prefetch_valid,
> -			"worksheet must be valid on exit independent from optmization resul!=
\n");
> +			"worksheet must be valid on exit independent from optimization resul=
!\n");

There is another spelling mistake here: "resul" should be "result".

>   //	DML_ASSERT_MSG(iteration <=3D MAX_OPTIMIZATION_ITERATIONS,
>   //			"exceeds max optimization iterations!\n"
>   //			"\t is_permissible_found =3D %s\n"

