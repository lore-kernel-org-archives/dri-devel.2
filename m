Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53DCD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE87810EBAB;
	Sun,  7 Jun 2026 21:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="But72Gez";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSM+/+We";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BB310EBAA
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:17:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657EkLHe846196
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=b7j6fWH2ZTuBoYf3DikwUXDF
 crJUfkjfuq65I6UYILE=; b=But72Gezh3J8O2kC7pcCgCeUO5B83TzWPdicivQA
 g19bqR3eLMsg6WosHQ36cxQOtkV5o6n+puHlydTYJg9M+usFF2y/WDRnVMD/m5tC
 LI4wPKcHTMp5c+znAZb4hadOrDuF1f60I6rywu0fRAkeKosyfnwZd9Uxr9HHTDfW
 KwRXI8Xq1Xnr7nDD0TVtDmCQLFeb04rNMSgc4ZAwJ8OoalbIu330DN5gPgPmsbZa
 RSKO85OmfXjzkldAeL90tkekubBWeWcWRwQv6CEt6YLnpTotwTGNzIuU+MUT/vYP
 8eyF/eliV3HLq6qYlVZMJ2ptEHT30V8N/QOm0w4exF9mDw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3n62f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:17:00 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59ec77e0184so3147668e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780867020; x=1781471820;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b7j6fWH2ZTuBoYf3DikwUXDFcrJUfkjfuq65I6UYILE=;
 b=eSM+/+We3zSPLYc8YCpWMuS9LSWuaDCQxvtKdQcoLd9YBY0j/5hlNW9OMF7yt0wy6R
 OCLUnQi084RojVdBY9RxFIQsDJUEc4ErvhX0Dxo2LjXcgoTxyWCjVAcRewsjDMTDbYil
 1p8jJg7YD0V+GBkIKasVZQ+9K4OzgZq4M5T0bnTRUM/nwG/VqOnHqUhSTSItKlrTukRe
 ySZjlvQNuukul4HxMpkmeHEvbXCobs2j0C6/MgpemrXPZlPqzogGXVN4py1sQcuSoMCO
 CLmY8QUpIgzSFpm5pmcr1UNrxKh5AkuNd/9nQ3x3IkSBwiz8Xz8uSur1CQusRxSbv7fx
 HaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780867020; x=1781471820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7j6fWH2ZTuBoYf3DikwUXDFcrJUfkjfuq65I6UYILE=;
 b=AjY5x/tvbAMZWro+/or5MvzZaUxG0C7mZAf1hnoxvYIakZR2vZ0/6WLAoK57Pms/kB
 BvemxeN0lj7hV3BnviBfbDX7JNIuCZvlP4AYx6gBzmpJy2TIbjYIBZL3+9pbeneDJL1r
 Y8N3tWLzgx5jGb14RAgQOazYx984PPU8LuJ/9rbghw7qCZGmTtiG/+H0/Q40Iq463uNw
 phOx/bUojV7VtFaelKsR9tAvsw1j6Qw0VWMcrUTCuYPkbEkQQZe/YIfVF9YEHdW0lK1/
 7FS6Jyl/Ie/RsC+RM1XcyEUT11ekMVNp6EgifxnmnjV2JeOfNB2wBopFBW9xptUJofq/
 BWMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1ofnJFL8w1JtnF9Grle4wJZ1PwLs6ltqueGCatpUAuTrVBKLacP6V8EJA1lXpODjJB14YiWG18W8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxweYrislkRqRci5wESZuhsTlp07Q61Fr3mck0ZD1INsn/1mRQc
 GxJ4HLBIVVF63fO7o9BRlSvvR4Peii7B8k+y4AcXE8pxLDbcUXB2WcW+Fy+7tjipPO2Ia8kMVAN
 5AQocuCv2m0/ixB6c+ZjosI6LvXig78ckdQk+3ZIx1uf4Z4IWQ0qW49i3Z1yGExa4ZCsilHI=
X-Gm-Gg: Acq92OEmvVnO2R30VPgwp82MdV6kTL4szLVCIF1iBYzkmt0I0b8K1K4ZBZfCfIHbBne
 YXNCxe67zhYGbBW3wBuOuavTfJJ1HWjUdXVUKGxI15Xx5kIOOHsQKFk7/n2KirUMvXO19gGKk73
 TlpT8yO/GrBEKPrSL6J3GqIUYDfJf+pM58NOL4yUYplr/NUV50QCghfqfKld8mGlqDJklaZZhtn
 3e8kIxvqZ1e32ANyz3YHSV0fQvjCw5FLDlBM3VNgNgzJph9yB8/9p1LxB1KFtXBp8/PzPnJT1Uy
 Iex6UQ1+si1UqMH8vDQvb3g5yDxS/TzjDs0/1FS2GICIuDPitYIi8A4ku8VBtzyKJTM8hhSMDX+
 6V8AGDRMNL8ipdL9cqd6Md1lApV+Ba9cmojEwN2k72H/O8Hnz8Cn7Irgj/pKzII+EQKOE9dfhCR
 Nz8/s2ok+MTvu5Fst06mkTJjBqOldk5kRMruLnZ0qP82sykA==
X-Received: by 2002:a05:6102:4191:b0:634:a573:c097 with SMTP id
 ada2fe7eead31-6fef36392d5mr4964746137.13.1780867020062; 
 Sun, 07 Jun 2026 14:17:00 -0700 (PDT)
X-Received: by 2002:a05:6102:4191:b0:634:a573:c097 with SMTP id
 ada2fe7eead31-6fef36392d5mr4964739137.13.1780867019635; 
 Sun, 07 Jun 2026 14:16:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b9040fesm3273761e87.31.2026.06.07.14.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:16:58 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:16:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 13/15] accel/qda: Add DSP process creation and release
Message-ID: <5gz4m3mfsnlwmyfiqtl34rgt7krgo546l6kslux2ibyinep3td@zs7xjxrk557o>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-13-b2d984c297f8@oss.qualcomm.com>
 <w44qzw2ryg7bpbte3hegopmtkfjd2gby532rdjarm4i3tylpv2@2rmruincfdgc>
 <568987b0-6f54-4b51-b1c0-416435e3f564@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568987b0-6f54-4b51-b1c0-416435e3f564@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNCBTYWx0ZWRfX4ZIm7ouAFFaY
 8H7aa65f8hJy2hDjak1/NzYVU5oGReTOAuFCqGrNXdMlJrOwGEajybnYmruyARt2D3Rvafe9PFK
 bPl/kJC4Lp1LBXhil18JhE4X2FenWXson2LGNRMtwWGJNmbinVKVcjcP4gGN7peX6Qz428d30DA
 y2QqO58zY/apHZX0inQcGRUur11vl8fvLJsrYzP+diHI5xVVsh9ydasUh0B615saCrfdsjS9VKt
 aVofrKTdLTJuNYTQZoJyx09WetJNK6cHtLzEtyMBpjLWPtJsjEhx6Y03pxqbFYb1jgwivIgVsGH
 8CzaaOogKI3h/PXsC2HWFlfdpmG3Yk/D5oMc1KybECWYYgFN2xjm53JecpZefLP0N0wjT1xj9Lx
 0f7I/QZUEjZmTQ7MDE4pUI1bQUk6nLvqrohREd4hEvWlUMTWbc059LjL/ysUlr3typIS1gShBls
 wWRbiAgFsVE/ZACT7yw==
X-Proofpoint-ORIG-GUID: 5xNjOKLk3jJKZjNcKXuIXz7diN_cYvvh
X-Proofpoint-GUID: 5xNjOKLk3jJKZjNcKXuIXz7diN_cYvvh
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a25dfcc cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=DtFIhfJECZ_mmoY6xYkA:9
 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070214
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

On Thu, Jun 04, 2026 at 10:47:13AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:30, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:46:03AM +0530, Ekansh Gupta via B4 Relay wrote:
> >>  
> >> +/**
> >> + * qda_ioctl_init_create() - Create a DSP process
> >> + * @dev: DRM device structure
> >> + * @data: User-space data (struct drm_qda_init_create)
> >> + * @file_priv: DRM file private data
> >> + *
> >> + * Return: 0 on success, negative error code on failure
> >> + */
> >> +int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
> >> +{
> >> +	return fastrpc_invoke(FASTRPC_RMID_INIT_CREATE, dev, data, file_priv);
> > 
> > Where is INIT_CREATE_ATTR, which you described earlier?
> INIT_CREATE_ATTR is used while `sc` creation so the DSP considers the
> request is coming with some attributes, the ioctl functions are going to
> be the same in both the cases, so keeping it unchanged and the decision
> is taken while `sc` is getting created.>

Ack, I missed it earlier.


-- 
With best wishes
Dmitry
