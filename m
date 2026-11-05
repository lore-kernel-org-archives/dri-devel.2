Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4035606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DWG3eOkk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512041123A9;
	Thu,  5 Nov 2026 12:35:29 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051871123A9;
 Thu,  5 Nov 2026 12:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793882120; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Uz72HdtyQIk/Jx/Kx8+D2p3/h8mj8zQG1p/ZQuEx9Ctu6YFaXmhXgaXvD47v/+AGyMuZ+RkOBb0E0AvGZaA2WygzN9avwB4BL1P5OioIxd7DOJ89ec+DFgnWaDaRj0NXgLWVoNDvqWYI2hycGqNTGDB7WrXm4dJDq6qflVkfFcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793882120;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LZXnIiN3GUw0Ikz0T3gPaUwpFENf1XFb2KeDlcXczwg=; 
 b=Al46/yeMX1achccMCKjlLVt9UmEm8U+GMthh3oAN/pCjATJZtUwKPzEFu4wYehVzHWTgea6wUaQYkG2HRT4aIMBffLRrOBZd2unFe7wFruujnLcH2c3e1i5Uhl//DhtBnT61p8OVKTWFTrImdel0o7NbJkuRJ/3311CnOrsMWRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=DWG3eOkkBDYLa23q1FTMIv8iDNe2lcBQrIYi3DJlWMUK6rZMToWXUvzV6DDZmDFj4XbepNLaJuzRoZRs2fLxMLJpROXUNSPiw0A7a4GmA6TbD0nE+6poAsud1nqIH1mvJW1c/sFBLkKI/Ha6VcNAUzeq58X6WG+xosGKqmA+Yd8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=LZXnIiN3GUw0Ikz0T3gPaUwpFENf1XFb2KeDlcXczwg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793882118217571.0019856779174;
 Thu, 5 Nov 2026 04:35:18 -0800 (PST)
Message-ID: <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
Date: Thu, 5 Nov 2026 13:35:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
To: rob.clark@oss.qualcomm.com
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
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

On 04.11.26 23:11, Rob Clark wrote:
> On Wed, Nov 4, 2026 at 11:00 AM Robert Mader <robert.mader@collabora.com> wrote:
>> Nice, very happy to see the series!
>>
>> On 04.11.26 17:36, Dmitry Baryshkov wrote:
>>> The comment describing the QC10C buffer layout calls it a compressed
>>> P010. It is not:
>> If I'm not mistaken the display engine / the DRM side (including Mesa)
>> describes it as P010+QCOM_COMPRESSED as well, and so does my pending
>> Gstreamer MR [1] . So if we can't pretend that QC10C ==
>> P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire that
>> up everywhere etc. OTOH if we want to keep the DRM side as is, then the
>> comment should reflect that, IMO.
> IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> as distinct formats, both with and without UBWC.  I'm not sure if the
> same is true on video side but P010+UBWC was never exposed, or if it
> truely only supports linear P010 and UBWC TP10.

Oh, do I understand you correctly that the P010+UBWC implementation is 
not compatible with QC10C, meaning on the GPU side (Mesa and display) we 
don't yet have any support for QC10C exposed to userspace? If that's so 
then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?

On the plus side - this would allow us to make the format single plane, 
matching what we get on the V4L2 side.

>
> BR,
> -R
>
>> Best regards,
>>
>> Robert
>>
>> 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8195
>>
>>> P010 stores each sample in 16 bits, QC10C packs three
>>> 10-bit samples in each 32-bit word, which is what the stride computed
>>> below (width * 4 / 3) assumes. Name the format correctly.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
>>> index eb8de60c1177..ec2bf2a2d953 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
>>> @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
>>>
>>>    /*
>>>     * QC10C:
>>> - * UBWC-compressed format for P010.
>>> + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed in 32 bits.
>>>     * Contains 4 planes in the following order -
>>>     * (A) Y_Meta_Plane
>>>     * (B) Y_UBWC_Plane
>>>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

