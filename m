Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B37C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAA610E236;
	Fri, 31 Jul 2026 14:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/wHmwzI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gszuxmxe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E292510E236
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:17:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VCGojn3978375
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=s5AJxZBwX5mdbJEKMHHuL+U3
 UVoTEIUr3b1RqdyL5Jc=; b=Z/wHmwzI0J/xGBX+2HmqQYRDu8BhHnn6cHf3Muw8
 0qTMsBv6bmscd7wjWtqoT9EpHTOUKPXI6lQ33V91h5tWxx0KOtz1VJRKQv4SGpo/
 eFpipcorY5wFkEy1VYvd24qzSYptHENOMsIydOd1WvHOeQwlWxp4wNUX1rFLz9zH
 9Ft/cu2YNufKb+1LljqtP463Z0K129st+JU7r4g8jQ1yJ65qWCIV4sSrvN1nOuLc
 D4WPztdj/VOKLuQd1WoQF8HBQK7/GoROobDkI41xPAA+U193OC9zulnowAHefoY0
 9WeEihGYFjHTgFxmkHLR90ug4g8RkHILezaF7VW+MMQbeg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frujurhqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:17:31 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-96feaeeeb3bso45557241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785507451; x=1786112251;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s5AJxZBwX5mdbJEKMHHuL+U3UVoTEIUr3b1RqdyL5Jc=;
 b=Gszuxmxe3Spw6gaXE1OeVrhIVGxfUKoFyWHp7gDlBxmsgGwpU+NMWBV6Ns0Cm4Erxk
 P1gz/lN6tcmpStZ5/VibdemMbaaxeCSRL61V8t0J9ZTcErGDbCjZ5/yWVcSisCsqi9gq
 7oB4cIX7OCGX9RMUIJImoX5fIWierLinPnPZBIotstSPjz3VAP4JfAth8JuFkyYloORo
 v2i5UrjcBs8Ew3G6N1Md5+V+8ixsGdNh9wpsCxlXHLG+UgmaMLWAJ+p3oyQiJRMhNIYC
 lHtL59wj/AT9t/lqjPUS5ZJuMuyCziy867qHBoiW4Ooz1/KvI0yqW+6GlPLmFdw98zLs
 DDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785507451; x=1786112251;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s5AJxZBwX5mdbJEKMHHuL+U3UVoTEIUr3b1RqdyL5Jc=;
 b=awnDhZ7bE/V5wtxGTnEkzeU+jY7ylimy8hyejdtxuYWj/pvgK5xUwkF0IXCH+j1ByC
 jHkM7PXmw/nZYKw3Vq7ypO6V7XVx0aP1WXXV15Cle70tWtGlokB5CSpHM9VH/gZHL/Hc
 cfECozLhZex+2ertplvhpfGV2nkgXJVShwkZLH1663+6RmPXWjA5Dm8P3wgOVyo5FGmN
 J3THB5p+uA1Ix30g/sYArzq198wlSf/dJrulJ2jXYOeo5i5LjGlRn+1pn1y1DNuS01Co
 YjDT0gJNLO4up1gTXdx3Gqmf61rpruZ9XQBa6lEDhUecPHOQSGj0s9wGDlQqdWyiYFRF
 wYbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWXfiqdxG0oZEX3NQcaavlh2YdycyOTPxOLqsuc5nb+GVcIl1EtR/F2t8d9qghCCeGWQzM5OKAQQg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhooZGHf1GlBlGrE30urGhOLfYQMlUmCaDMspT2FBn0sobncz6
 /vXWBL/DddkFRvBNYcbAGdRjbI8eBvRHjYI06NUM9iqppMWhfWiyVQ7oAUZAV1PZJnd2LDE+SQB
 iGWJ+wF6cKFMz4ZfetqQ7kkA4Hpyk0d0aG4S6WhvFhli6xwvoRKtbduW+0nv6MZNPmpG+c18=
X-Gm-Gg: AR+sD120aM1BUwuG54YXjUgm9vmBzWcDh1i2tjl99ASRKtLSz73fFe+Yc4PGEYjt62A
 +yOaxMEFTl3CbBpI5ecMfxYFcWIdG5DxG3iAhD8aj4SjqwxwawbwsYBAdmH6XhAbDlbRnIP+KCj
 EUcKYytREs4E/P49la/DlMXDOjSyhB9jh/mt26xzJTOfvJsTNITdfMHw6k7ok7iPRRgi4+lNDrb
 BKoeu+muKPviUW5ii1xKOe5P9AZYM7EooN2gnlgxQr/Bq5BUIB4Rwsog6+oUl9P+Asz3sF7ZAY1
 O0Ki8zGu9mXlhDX0vkdbiNLZmd2xRaWZCjYyHSR5GqfV0uoz1OETxHl4LXD6PbNjDvVoP+FMDw8
 PJVoO7QaZizd5LyDL4/IDIIyiEckW8o9LaAjnit3L1M+wgMUGuOUOq+3GSW1Nk9zJoCdIy0IPxO
 scc+9esVnZDoXrVw==
X-Received: by 2002:a05:6102:549e:b0:6c3:1bcd:31dd with SMTP id
 ada2fe7eead31-75b2226aa3cmr244639137.6.1785507451135; 
 Fri, 31 Jul 2026 07:17:31 -0700 (PDT)
X-Received: by 2002:a05:6102:549e:b0:6c3:1bcd:31dd with SMTP id
 ada2fe7eead31-75b2226aa3cmr244598137.6.1785507450531; 
 Fri, 31 Jul 2026 07:17:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23c46ebsm329552e87.10.2026.07.31.07.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:17:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:17:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v11] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Message-ID: <ba6v23dn6mmhnowqigsojbnjnuhzr7hwmoe3treklr2zpbnfxt@vgvdxiarcb3k>
References: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=U6Giy+ru c=1 sm=1 tr=0 ts=6a6cae7b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NXPZQVn-1uHl1nTrLQEA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: PNh9NjsR_whedvQc9LV_FsqmtH0yAc5e
X-Proofpoint-GUID: PNh9NjsR_whedvQc9LV_FsqmtH0yAc5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwOSBTYWx0ZWRfX3H6PNY9sLHsK
 aNwD8hrrkV0QdmQ3c16+y7IPboxce3qx9yWjREZyBDq68gpvRmVUf+8iIyvJBy5mUgte+gmE2Oo
 m80INYTKRy71JqlktBdPB5DWX2o1yD951StOu96CII9aN7JLbheDnfBe/PPLDoUHPxJ2s4URIsB
 nqhh6aBzxcejhizE8UsFawad0KjnzjK7OE2on1y6yGOx9WIIZJi1GW7OXQt6DiMmuzyBv602VjT
 HmtMRhehPZQbx94HFIFEaWGgtUjQxBQWtbsbmQUQSdSjD+YEZZrp4BMXMTP96SsVh1jxyS4QzPh
 EA1CQXsvSdvX9xDkSGWkJyhNVy1oKiRAudgxD8IN2xZ/EI3DSRmxf7/dMtwdLefK6ysa6L2GEKv
 +Oo6vz8V9/rYLudH8/p+uKFjX6At6B63eyczXVMbu3aM5HTWE8s8f0Il89OgLXJ2nPfsD69wO2L
 hDvB8ynytcCGO8oMZVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwOSBTYWx0ZWRfX6CIS4V04A9+G
 eRrycRg1kkY2j5+i4OM4BAxDz23kfVGxrKQw7Tv60oaW//ENUR8RZfgn9sKxh20G8gEKqVXfc6Z
 Qhl7/y/AYQQSCLph9BnLkXvQonBVSzU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310109
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

On Fri, Jul 31, 2026 at 05:32:10PM +0800, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Additionally, the current implementation allows userspace to repeatedly
> grow the Audio PD heap, but does not support shrinking it. This can lead
> to unbounded memory usage over time, effectively causing a memory leak.
> 
> Fix this by allocating the entire Audio PD reserved-memory region during
> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
> userspace-controlled alloc/free and ensures that memory is reclaimed only
> when the DSP process is torn down.
> 
> Validate the presence of the Audio PD reserved-memory region during

This will break compatibility with existing DTs, which is a no-go.
Existing DTs _must_ continue to work.

> rpmsg probe and fail early if it is missing, so that a misconfigured
> device tree is caught at probe time instead of at process creation.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> 
> Patch [v10]: https://lore.kernel.org/all/20260716095847.479-1-jianping.li@oss.qualcomm.com/

All of this should go under the --- line.

> 
> @@ -2584,12 +2547,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		}
>  	}
>  
> -	if (domain_id == SDSP_DOMAIN_ID) {
> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>  		struct resource res;
>  		u64 src_perms;
>  
>  		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
> +
> +		if (err && domain_id == ADSP_DOMAIN_ID) {
> +			dev_err(rdev, "missing mandatory remote heap memory-region\n");
> +			goto err_free_data;
> +		}

This is what I mean. This has been working beforehand. It must continue
to work.

> +
>  		if (!err) {
> +			if (domain_id == ADSP_DOMAIN_ID) {
> +				data->remote_heap_addr = res.start;
> +				data->remote_heap_size = resource_size(&res);
> +			}

Too much of the spaghetty code. Can we replace all domain checks with
the functions?

>  			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>  
>  			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,

-- 
With best wishes
Dmitry
