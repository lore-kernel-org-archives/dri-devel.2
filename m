Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C00FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 17:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0160C10E133;
	Tue,  5 May 2026 17:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mP6VW3C6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSC2MuK+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84FD10E133
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:20:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645B6OMG3091455
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 17:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5+dbc3v3OtmBl3m6PxPaJUCW
 h3BmROrwWQqLBIPzX2w=; b=mP6VW3C6CQRjZ6exLKI8+tEqoW+5Gt3Eg8GRENBB
 Uij9G0SWox1ecPB336oLLe3usbjRLn4i+yfMt5aJQcLoelDB3oc3HO4LFnnNMC2y
 ju3cfbqVNctTk8dy0nRu1YwtFQaTsKr5inlg1mCPQvBA40Jn442XXBJg3NOLIWqp
 07Z+j72cQINOMX1PMTF5XCgUd/Oh+XEj2KQ9F3Z8HY77kc28Mls8ZcLrh8C5UQ2W
 KHymiLQtlo4QsDMVuhVc4KwoCt9pTmDfCKTp0nfJB4FTeAMyyzzB0zwQgrmNLctX
 0Sak6xuzw25EXWpDTny8ozLqiNsb/wnN4Wzi/Gi2zME58Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyfct1ft8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 17:20:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso51405355ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778001603; x=1778606403;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5+dbc3v3OtmBl3m6PxPaJUCWh3BmROrwWQqLBIPzX2w=;
 b=dSC2MuK+v7HzEm6vSLqJid5Qgom5iGTOCHyQkjC6bWxBysvTbsUfI9qnkO0pP4Bk6w
 /mF3u08gq15Kr1hW6Pj1l9tfAUXDGcAyHNBcE4HXCK+GVUcgKZe2B6rVFICBsTtM93Oa
 5o3Aq14V3HQ1XoeI+ehaMBT5dXMLtXc0li31uvQKswrNZqTKwQ2/kWbURxF7PVvLvPh8
 P9iLXWIKc4sdVmQLPDpKOyX/9yS3YXpFMrYaj47QllX63plQLJNPkTZX3lXFFePcQefb
 5GRglMz5Xwo7Xf95ZcrLKK3O7yNzcgapcdtcM5TasHrimWYIKIyBkjYguBBVrdejWQhr
 SP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778001603; x=1778606403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+dbc3v3OtmBl3m6PxPaJUCWh3BmROrwWQqLBIPzX2w=;
 b=Ez84lOf+87v2gwj4DHQKCHjqYKYszRev8XChNfMo5YWDnW9nPrrpsN3QQIelSerKL8
 5+LAWl2qlAtwDZ9Vln4UKzhxlzyBx5mezGau+H2TyObii7E9NdCb6VqreQ+9v0eyAfMI
 DcAzGPHW8ZlKjNwPuRPqBCCmkdiZP2JIuDGL4EelFVCvCrpGQ6wZht5vC2Z++mRfTMnA
 KZ5cnyajhGfBhmAiuGn6eaeO89/h3ZxDgFl3O29WM7dcyR9Q+WNWiNTuxMrcoyJiu3kn
 FYSBmZ60s/PNqck1MH3wllNuWSoSltRFdrCMighEcXtRvMSZQoX8TF5wqayM7OrN4c8P
 BguA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Bvqx1mmFFI0Vzbgr3axuVj7vAQyPS1L1nB8BjNm42cPIgXLLVoH7hT/gIJnll8KfJk0tV6eVv2BI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyacJPSD24fH+9vU+OFQ7Zr8CKObW69YzGbL/Dvfy+bBRWjCiwz
 C8aSxTNrIla5NovUTrpvL8cPyQWthDonZMwsoE1vk2poC8cB/ciTvQCMShIoRRb6++XJ2eJdr53
 i7R84S8tTOvLXk9qWVnEf2SV5zcrZvuQISCWbabpnqviPSkTpIvY8Ijp6Vy+6TPRuVrmNc64=
X-Gm-Gg: AeBDieuVH6CtmMwvCsjwKgX6t2Re6HgVyNKgXhRGA7bYKVMvg/XZHjs3ovkPQUjdpsE
 8v+mxDgMtWVCW5CGLYNZUmte6l2LSi/+QZryBJa4cvJmLV/5jg1DuHgMj/M4S7w8LQcgjl1B5ep
 Pzohxxrov0cK5xWpL14Gq6uPJI2//mmRxq8Yc0RrLu6/0ohniPG5Sm7oYGEpScg+LpOO02m/BLS
 s5k1N05KZfoc9y0BfSBORTzmlR52VDM453u1LpxhMhgxhwTRcH+p6jJQ22I+1i+7Vaia/zW9rFT
 Gt0ZJoboYDDvpYrVQWgPxRcpdkZhm283+ChLt1lc7dK1sXwHIjcTGJu7A/Gxg5mGNk0FWPqial8
 +7wkKpzCr/zgaDmgoVxhHdFckOo/Ae3fziyimSfkCJXUiQlHnAKwPqePer58=
X-Received: by 2002:a17:903:22c6:b0:2ba:6bd7:8efc with SMTP id
 d9443c01a7336-2ba6bd79004mr14146855ad.40.1778001602469; 
 Tue, 05 May 2026 10:20:02 -0700 (PDT)
X-Received: by 2002:a17:903:22c6:b0:2ba:6bd7:8efc with SMTP id
 d9443c01a7336-2ba6bd79004mr14146395ad.40.1778001601913; 
 Tue, 05 May 2026 10:20:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa7e791sm145314855ad.7.2026.05.05.10.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:20:01 -0700 (PDT)
Date: Tue, 5 May 2026 22:49:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in
 rpmsg callback
Message-ID: <20260505171954.uto4a7jmxptlaa5v@hu-mojha-hyd.qualcomm.com>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
 <afjprOhBhP15-2lU@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afjprOhBhP15-2lU@baldur>
X-Proofpoint-GUID: oI7YcJX2xUAlmTPAro4zGqkCALPVwzEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2NyBTYWx0ZWRfX/UT4m2gkFbKJ
 zBBFODYEEQrkyj5BfzqhuO1qjYA3OxxB4c3nU404NOP4zLVakj8gQdVkxr+p/vpMN/dcIcYE06k
 lxi202EBqIaveVvNXgHs50BGNMFzbv0IzB9Vu+LRUuBZgkLTuIZVxr76N6iQg0WxegkD9Qy1e/q
 j21F+dwGt3vMGDoA6I7XTBgaFO0WOX8lhigH94deURZACw3f1ZjiNUgHXHJMSjdAd50U1M/qwyK
 D5XZDdu6nWPvWN7qtR8MKsHroCEEJB8MsdEpVZQ/VU8n23lVKi5X22H3KGD4fAUzQiIcMNFBfIH
 aGt3BUCCVhBPZbnHGim7jhf1Tjgr0gIggdBaWzyq7E+B5MEtjSc8cuCjL/wBvHXB7XE5rOlDvnC
 dc2ECWSRK9VHZO7ML5hA5Ow7a8qLGZQqTSxrjGsM2wAjYRyhQkRPn/Kg8kkL0JUghmmIvUG+9lu
 JU2Uyb662vKmsh0H7JA==
X-Proofpoint-ORIG-GUID: oI7YcJX2xUAlmTPAro4zGqkCALPVwzEl
X-Authority-Analysis: v=2.4 cv=NtXhtcdJ c=1 sm=1 tr=0 ts=69fa26c3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_ffyFokNbbV7GOtJ6hsA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050167
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

On Mon, May 04, 2026 at 01:53:37PM -0500, Bjorn Andersson wrote:
> On Mon, May 04, 2026 at 10:47:00PM +0530, Mukesh Ojha wrote:
> > A NULL pointer dereference was observed on Hawi at boot when the DSP
> > sends a glink message before fastrpc_rpmsg_probe() has completed
> > initialization:
> > 
> >   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
> >   pc : _raw_spin_lock_irqsave+0x34/0x8c
> >   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >   ...
> >   Call trace:
> >    _raw_spin_lock_irqsave+0x34/0x8c (P)
> >    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >    qcom_glink_native_rx+0x538/0x6a4
> >    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> > 
> > The faulting address 0x178 corresponds to the lock variable inside
> > struct fastrpc_channel_ctx, confirming that cctx is NULL when
> > fastrpc_rpmsg_callback() attempts to take the spinlock.
> > 
> > There are two issues here. First, dev_set_drvdata() is called before
> > spin_lock_init() and idr_init(), leaving a window where the callback
> > can retrieve a valid cctx pointer but operate on an uninitialized
> > spinlock. Second, the rpmsg channel becomes live as soon as the driver
> > is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
> > is called at all, resulting in dev_get_drvdata() returning NULL.
> > 
> > Fix both issues by moving all cctx initialization ahead of
> > dev_set_drvdata() so the structure is fully initialized before it
> > becomes visible to the callback, and add a NULL check in
> > fastrpc_rpmsg_callback() as a guard against any remaining window.
> > 
> > Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> The fix looks good to me.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> 
> But I can't help wonder, what's in that message? Should we make sure to
> handle it, longer term?
>


4.662080] fastrpc_rpmsg_callback rsp->ctx: abcddcab ctx: ca

It looks bogus to me, as no ctx id allocated from your HLOS.

-Mukesh


> Regards,
> Bjorn
> 
> > ---
> > Changes in v2: https://lore.kernel.org/lkml/20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com/
> >  - Added stable mailing list and fixes tag.
> > 
> >  drivers/misc/fastrpc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 1080f9acf70a..a1a54453bb7e 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -2431,7 +2431,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >  
> >  	kref_init(&data->refcount);
> >  
> > -	dev_set_drvdata(&rpdev->dev, data);
> >  	rdev->dma_mask = &data->dma_mask;
> >  	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> >  	INIT_LIST_HEAD(&data->users);
> > @@ -2440,6 +2439,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >  	idr_init(&data->ctx_idr);
> >  	data->domain_id = domain_id;
> >  	data->rpdev = rpdev;
> > +	dev_set_drvdata(&rpdev->dev, data);
> >  
> >  	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> >  	if (err)
> > @@ -2513,6 +2513,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >  	if (len < sizeof(*rsp))
> >  		return -EINVAL;
> >  
> > +	if (!cctx)
> > +		return -ENODEV;
> > +
> >  	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> >  
> >  	spin_lock_irqsave(&cctx->lock, flags);
> > -- 
> > 2.53.0
> > 
> > 

-- 
-Mukesh Ojha
