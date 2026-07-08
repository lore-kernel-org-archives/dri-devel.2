Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54DBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4159A10E56F;
	Wed,  8 Jul 2026 06:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y2yj37QQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKjznQ5B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF13010E56F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:11:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842TEQ1447452
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 06:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YbwKyhVXL6M2THrTeKIDkFqZ
 YrCtq+4cO/T9fIPwkoo=; b=Y2yj37QQkjM55p4WSB24ihPMkax0LB9KjpY7oQNY
 6LTxCyIp7iiSe4VO2z9XjzVpLKSxUWHUrpRPlqu3dfJoNzZiHrLiq1+Im0e6reci
 a+HkJaFAfwDlHLiP8BJciUDfkdbPvcmjxcAU2lrkm/Is87xmmZJkV1W7Hp7/K3XW
 yfCiTy0M1TarxkxBFKzxZLExDYeRYlRNhNnao5FtAsQ5MH5PHXQwz0RURPDFth6+
 DLob+KIaldeJIAaA6bCZLZj0WXNXSh58ai3jWGitcKFnwZiTXfTbVNIHArDf2U6/
 dgG6CUO8How1qnvHaq/0A2eAmsiRp64L8aHGPfsW4NxQlw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11xvh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 06:11:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-737f1f1e0e5so86234137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783491112; x=1784095912;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YbwKyhVXL6M2THrTeKIDkFqZYrCtq+4cO/T9fIPwkoo=;
 b=BKjznQ5BRAYIObRqLuDSzjvTEYJzo+wr+xOuEnU5Tx7LglFE7EG+PmJAyNEYddsvG1
 Wm815+OIUVTdr/I6xSWhu8MY22Iaxm3QFXA63hY2gl5dMAHlLT3kSemgMCI4MBZdXu5M
 AAgtQ7ok8arT/O2hZprfj+QTK9V91rgxZO8jmL5UrAZpRmmvbySNhrHQSW/b1ULhmcEr
 w20hgBWpHNu0gviQuZp90GgLv+uFL9op9/ADs0yyEAz/L5ZV/GLKj378MJ2x0tvJK8cJ
 HuW4BKYQ+2r9bevVvnE/pKo1DbzXy3r5Waj5J4cY5lLSy7vcTpvVEItJa8JwJegBSgHo
 vTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491112; x=1784095912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbwKyhVXL6M2THrTeKIDkFqZYrCtq+4cO/T9fIPwkoo=;
 b=oDc0Q6ghwOBwiqh2zXX+UlH0BEveercG9d7y9kE7PrqCpkabA6gfkWjTBznEhr6ZXH
 GsrG+7mVp34wbGGr8U2NirPW8G98Qs+alcFV/Gm5AJg7RBY3/ngmJqbjgzXDL5O3ySRL
 wAZH/8bLioi/lNBsh7B9+/IVcFb/1gkd2eng/ZXX38PnrgvYvVYoHdxFt2/F27SaMzxa
 M18cAR0nvgGZczegTeu0sIp3zRIwE0rAqnyxLCBqW/GjLGkZ/cmbV42zz9zJK6voJoft
 JB82ofzMVX9FPjh0G558sYZ5Tileqdzolpf6H5PLLa1m75yT+PwOvttbWzH0DPAGNNOF
 Ee6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN7uHY/KsMb6ubpM3NEeDmL/Whqjdm71GZYWcfXnDCQtY6qJ23ZPl2taxtME0ccXgihDud+4T7yB8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgmaQTRxH8Q8Tj2fTcoR8SO5J3FDZIBnjHBpm6QDUumdukjL/j
 PWsE6No+ggJMrqdeRHD6d520D6YZnZWH/cSlhV+wuhEPRJa/51LpmP+DeujtiygombeYJl/i7HO
 R7BOmkXANclcUt90WHxIxozfvBMOQnO8h0Ovb/wnuzxOJanQq2sT4bz4BhjDzeaRRNf63ULw=
X-Gm-Gg: AfdE7clvuo1ISNfUqKafje6y8kfiPDLMFuYeBCrVyGPDqBKFxJkRmvIh8MJX9KSGiVQ
 n68Obl2MilwBqlFs8dQ5FK+hcgC9mQLZAKNex+mn4DagtIhA9vdJ5AK+yEv6GBzlJ5HANYZVFYS
 8yLdidkg8QO8vomEVZg4c7Y9j8LfU/8vC9rsCq+2ZY3keI+FAz0WRf6g0QuRuFI38zcalgcp3Zc
 NbsPECj4hApN5Y1Og0brsxnY3ut1JyVRHkDk3xGw3+oCQ+lkZQ9VgN1WX4EYS/JE6nmx4SkZQxW
 c6oONzj5r95oS8yvInkKr4Xh1+kBMWRoBaAhcKo4Pyj2eLLp+03noNO/byxf/p9SuRDsdX7g/Yl
 tGGEcIsz6Mmz6S0RCGULx2r6N0DVp0ooXU3eM4g1UbkEdOMYwDDqrPgZoO3NcDY/fawNw8+cJ5x
 CG1ZKtPMivVMFGBX7cGhMOmHPw
X-Received: by 2002:a05:6102:5e96:b0:6ef:db57:ed3f with SMTP id
 ada2fe7eead31-744e0311b62mr418961137.29.1783491111923; 
 Tue, 07 Jul 2026 23:11:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5e96:b0:6ef:db57:ed3f with SMTP id
 ada2fe7eead31-744e0311b62mr418945137.29.1783491111461; 
 Tue, 07 Jul 2026 23:11:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c0117sm4285796e87.62.2026.07.07.23.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 23:11:50 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:11:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: create duplicate sessions after
 all CB probing
Message-ID: <rj6a3dko5h3p66yxn22g4wymfkqqpdrs5leuxyeihehdzxzsga@rpc7n6tjhklq>
References: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
 <20260708-dup-sessions-v2-2-da40f9c98a2b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-dup-sessions-v2-2-da40f9c98a2b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ckLmnru-ssv-OYYC2-kbYqP0_2neogcK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfXzn7Z2KkFC6MQ
 7gBtBDiFs/BP2rYEuCFP5eie5jW4lwAjawbojel6zICOLIel2sO8b2Q/ZuhzYBlnzSbJjdRbrbS
 b0vZbjUI0RjIFbqvDw7MyvqEO6DNvaw=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4dea29 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zWMBRB9ZqIQM0yNuxxsA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: ckLmnru-ssv-OYYC2-kbYqP0_2neogcK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX60M1kISBGZ9l
 xsrdxTZBJuF80B5fCbPX3/9hNa9qNYEKiyVf2zFOFBqAECv+xOwt/HKp5VFOzFnwAtg44phTagp
 +vht1rqJsnlNU/Pj9HZAbE8ngalckwD7zB7l5Ln7Pi8ZfJ/tzZCrxAqAsU4gUc7AboIX1sy8HYF
 Yg0JedyMBYoZqF0ZAJalCFc9Ov8BsFA9HKiJyfu5XLft+qqSuvK9lanDOQvO9GN4WnQKTwWMIIA
 W4myHbTD39pltr7o05YLl0ij4j2CnrT+8tslEqVXDrdOabTXV9o2EDatPpS1ufhIZq5eA4Xhe8+
 OXC8BVbCnnl02e9BP9p+mXr5m40AZmYQc/F1UBg5++cqi88lIHy+yXB+oWmXoMvLK8bvZ8hmmhU
 es3iVupDmN1kYLuY+wkiMBrFQ+erETs9XD3+hR/fQaDU4eiNOg7oNpYxPg9nCwp7T970mJHb3/L
 Akgi93e5qB122dSjCHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056
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

On Wed, Jul 08, 2026 at 09:28:33AM +0530, Vinayak Katoch wrote:
> For ADSP, only a limited number of FastRPC context banks (CBs) are
> available. Each CB supports a single session, which means only a few
> processes can run on ADSP simultaneously. If all sessions are consumed
> by fastrpc daemons, no session remains available when a user application
> starts, causing the application to fail.
> 
> To address this limitation, a Device Tree change was used till now:
>   qcom,nsessions = <5>;
> 
> However, feedback from the upstream community indicated that this change
> should not be made in the Device Tree. Instead, it was recommended to
> handle this as a driver-level change.
> 
> Instead of duplicating sessions inline during fastrpc_cb_probe() using
> the qcom,nsessions DT property, defer duplication until after
> of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
> all compute-CB child nodes have been probed and the session array is
> fully populated.
> 
> For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
> last probed session once of_platform_populate() succeeds. This keeps
> the per-CB probe path simple and ensures duplicates are always derived
> from a stable, fully-initialised session state.
> 
> The qcom,nsessions DT property is no longer consumed by the driver; the
> binding and DT sources are left unchanged.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..8a3944f6c036 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -30,6 +30,7 @@
>  #define CDSP_DOMAIN_ID (3)
>  #define GDSP_DOMAIN_ID (4)
>  #define FASTRPC_MAX_SESSIONS	14
> +#define FASTRPC_DUP_SESSIONS	4
>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
>  #define FASTRPC_MAX_FDLIST	16
> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
>  	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
>  	unsigned long flags;
>  	int rc;
>  	u32 dma_bits;
> @@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (!cctx)
>  		return -EINVAL;
>  
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> -
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>  		dev_err(&pdev->dev, "too many sessions\n");
> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>  
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> -
> -		for (i = 1; i < sessions; i++) {
> -			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
> -				break;
> -			dup_sess = &cctx->session[cctx->sesscount++];
> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
> -		}
> -	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {
> @@ -2445,6 +2433,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
>  
> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {

There is no guarantee that child probes have finished at this point. If
you want to make it work this way, you need to replace
of_platform_populate() with the manual iteration over the child nodes,
creating CB device for each node (also getting rid of
fastrpc_cb_driver).

> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess = &data->session[data->sesscount - 1];
> +		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess = &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
>  
>  err_deregister_fdev:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
