Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97D606A33A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dOrhpNMv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27810E206;
	Wed,  4 Nov 2026 19:00:09 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BE010E206;
 Wed,  4 Nov 2026 19:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793818793; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J5Nk2Imxaf8oS1qWOaYZ/5p36mXDAYuXtOJxtp/dopGz+YZql+vQvYrpX8mB7IauHA4Xk8YQi1qu+PaPR6mB24yVfAOhT6/bxucXIyTgAr5kbwboEEEoK0r/KXXOvBMiOSZV7ITsCmtFClDMxvvdkx5UHygUVxFFFyU3jHRL1IQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793818793;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VzZMLJITLVDB0A5Z42maKwswLtuUp4zeciOTqXGQ8aA=; 
 b=IIHGp0XFAy4EBAI1xAOPiJGJtjBnAKa1DW4/mE+dskb/wg6rrm+SQ1O2NbrAIvdInYgZaN69e6gP4ugz8c37N7g/budnSoj0+vfCaDRddEsiHdsgyTHEUdlWXBny9WMxT0bGPo7exVlXSK9F2A5uzCRCit861dBAtMweU4FMdr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=dOrhpNMv1PBqHvf04rmXTIspsXaESd9P7WOVtnMpEGyERmcXNvYese409KE9Zwza09rugcliorGeDQvjrr3MppjkVnftXWuVC1JjjPXfqzc8ZfT1DRcgWJ3GieaTP0rd+PN8zqGyAj7OxYG6dJ7ZZp98FLi16P60Y7MDl9lIIto=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=VzZMLJITLVDB0A5Z42maKwswLtuUp4zeciOTqXGQ8aA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179381879157175.33447173328659;
 Wed, 4 Nov 2026 10:59:51 -0800 (PST)
Message-ID: <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
Date: Wed, 4 Nov 2026 19:59:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
Content-Language: en-US, de-DE, en-GB
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nice, very happy to see the series!

On 04.11.26 17:36, Dmitry Baryshkov wrote:
> The comment describing the QC10C buffer layout calls it a compressed
> P010. It is not:

If I'm not mistaken the display engine / the DRM side (including Mesa) 
describes it as P010+QCOM_COMPRESSED as well, and so does my pending 
Gstreamer MR [1] . So if we can't pretend that QC10C == 
P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire that 
up everywhere etc. OTOH if we want to keep the DRM side as is, then the 
comment should reflect that, IMO.

Best regards,

Robert

1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8195

> P010 stores each sample in 16 bits, QC10C packs three
> 10-bit samples in each 32-bit word, which is what the stride computed
> below (width * 4 / 3) assumes. Name the format correctly.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index eb8de60c1177..ec2bf2a2d953 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
>   
>   /*
>    * QC10C:
> - * UBWC-compressed format for P010.
> + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed in 32 bits.
>    * Contains 4 planes in the following order -
>    * (A) Y_Meta_Plane
>    * (B) Y_UBWC_Plane
>
