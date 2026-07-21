Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97818C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF9A10E330;
	Tue, 21 Jul 2026 13:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIOpLeQU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WrI4VVWX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1301E10E330
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:41:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDMFCv1910359
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k4E2eWDKLcnSPoYw7vDjCZz9
 5PSBT94/QtIXEfEoZP4=; b=XIOpLeQUBLN1jHSc3o8d4n2p8dbHRRcsZ2CL5Se1
 Yg0ZCP7vik8xr/PBR5e8+E61kbHwgRONOJNvwdiCsgW+RyWeSZJRv7WPOZIi+pJy
 aeHfNn50ey3dSDLSpg+SqmDrZs+rsSlrpJoyQBY5abLp53dj8FWTA93EmKfeCHlp
 d6TOitrkkM332gnzgL0ZhjQKvrFvEIwpFW5ojD0Ygh4ymXHgV0o5R1J6irtCuTaL
 fvTyoXEkXKCU2kR5mgahbPQIm/QaXDas81igVRaJqmXr/T6NmL78BOUIoFF0gx6H
 zgeY6TQ0TJWoSB/gjnHjl/Eltnv2f7m68734N/ElRqRWjw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvtn7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:41:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso128762311cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784641262; x=1785246062;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k4E2eWDKLcnSPoYw7vDjCZz95PSBT94/QtIXEfEoZP4=;
 b=WrI4VVWXGi7iWv7CS/+tuHCIrFqhLcITVptwHYFGV4Uttk/tugRjKujp7YfeioQ4jl
 bxqtqp/XDSpBZPa29szNwqfmWDZS4uAj9OMRaedzMlUFkBNCgK/8b9Qd0GU/jDxtKecL
 sOJyF1BNp9MOsQru3uKh6XLho3bMRPNHDAylbn3sCoACHEqkOsiiXsWtdOscsS5oxOqm
 Jsb6tEj6rMFM8zYx4xyvhZPoWUz9vcFX9Yxbg18Jch0ejlZ0w1xIPqXLAFSUtSqyXzee
 fcmWwfQR8wKGJuNpC0qAAhVcS9A1mmxDm3rNvUx1CiGoPNAMYeq62WCYqAIwsada6sSw
 0gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784641262; x=1785246062;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k4E2eWDKLcnSPoYw7vDjCZz95PSBT94/QtIXEfEoZP4=;
 b=JTzuw5d6W/leDrZBnFZFbBawYzHDHBNSBlaTMJm7lFUY+T0AO7h+JIMpqgJN7+27sS
 ohccGM+rPAdDgnHVudICfgEX8upz6E5KrvTtAl65a5yq0MCfI7HKvhai0HoFjBjTBmES
 bkvCinpx4CJZODWDurFkKTOVeeZnrgMBlo+TqQ0s2MUiopsPMWnJP7beBYCMa7K7F6uj
 FY4higUus8m4CB8Y6/eYgCKa9mWZBSbZ/2Md//GsQRtyLpQVGd133wt1fMGInXPg8a0y
 qYKFvqzKB38wZYh0oId7z+GpqigfNdwQqrxgNznP5PGD4dblz8S7Z5ZxhDqVUltSo+/Q
 hrBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzjkvcJk3GsP4USGdgi8/gZs1Rpzxq6qMEpCVnwj27Nh/L5dOl9bMxpW/oywlzJJJ7AM17EhyvpEA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb5B4niOLaAvCB/xJQ4BQZDOMDZt/o+a9b5+9/54Nc9iviBYrr
 xm7+ddL2lE6hL2mS/qST7FEn4XJ7vis+xryCAerG6gQruDUNfxhgRdpvOor4xa8OFGMAKnutJZY
 EpqmFPDmJahLvTYMxZU/Dm8Fp+ciIStilI0ITKgtGiBr8bXACZaZHyBnWiNFhgBpI6+IT6H4=
X-Gm-Gg: AfdE7cndHBGTIRSp9pV0J6NYfBtHPC2m2/TlfYsRHRSzqJWm6ip/k/LibE6b4mp4pNh
 7KeRJlafgmPwlnnnr6KDEfyEyxV0AGH3g3ljIUCW9hEvoWXY/KWNj6OS2GScTOzmZZEkvok6AnM
 TD2V37d6pPld0qKcm4S91rcE4LQUsRE24o4v8GKzNVf5UY7OiBtf8vrLq1A1dc/GXlk5BzM3H4m
 vTVw1CSymsvAtF9LjJFT6ZQgWHuiusv3YC6GpuLzQzmc8Q6dLHvv3kRO5q5WHyH3VT7QKtr9+LY
 +Ai2PCOZLZoZMOGNUSfxqvI6r4mN+5MI4xmSE+fs2ZTqbUBzi7rJY+9Xea2ZFohZuKedg5gluZ9
 ESHwvxPHQTPlZn3FiYFMODPoy4fWJQN6s65/8DLQnb876U0ZyVvOSw8URYBSpNdnUdxc9ubKACN
 jhY0L43NwKtde5Vw==
X-Received: by 2002:a05:622a:118e:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-5213d2b6d47mr167996741cf.10.1784641254651; 
 Tue, 21 Jul 2026 06:40:54 -0700 (PDT)
X-Received: by 2002:a05:622a:118e:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-5213d2b6d47mr167996461cf.10.1784641254232; 
 Tue, 21 Jul 2026 06:40:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b291e1949csm2902431e87.65.2026.07.21.06.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:40:53 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:40:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
Message-ID: <6rmntcmouwenb3t5xk5rh2rijd3sc3re5m4aeuqive3wifn6ux@hauua7ltycvj>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
 <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
 <20260721124005.E00041F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721124005.E00041F00A3A@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: uzTogCLdSpYcr4J4yDbDVFah-5Nek1CB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NCBTYWx0ZWRfX5Oki2PDVWOWf
 OWIm+If+Hu4r/DYfIsBb0gYgBooWooOM447BL7HlggQ62ZbF2DKgm7vYC2/BBPNEfQgdlI7/vMI
 2u+godkt62UQmaD06n/P1UdC4fFZC2g=
X-Proofpoint-GUID: uzTogCLdSpYcr4J4yDbDVFah-5Nek1CB
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f76ee cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=x8C9OYS-9AN7LrXSNBgA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NCBTYWx0ZWRfX1Zt/7P7hh3EV
 0nS0IEO/s4ZEvffECBcUQGCTByKgug3Dc+KenzTurpzOUTzSRc4pHvuedM3SSeE9JQFe2NCM2Fc
 PwWUxNWWByx60JWAyJp6rTlDKTYOpTapfGpxb70fEwe8nzbi0OU/QBr0EpmC5mIINBGu2mBU133
 VtcrLy5prDajFZA1zgW6oA5xLdgpX1ZXPHRe4wHsSCUUP01quVIsdqa/YrGcacFOeP0Ha/gErgc
 VOfDzPyKOZgAPkpBtG7Zua4jYlwSfNcSKykguZ76ge1EDK+jRMLKVMR7HWkkGhYI22dpNE8KhED
 w1NgWXgxw1Z2L+Bt6DsQhUlo7rpgs8+G98FKrG4l9k6U+0iQVPoDD8sB+Po/XcQ8VxabAzpdpCi
 rvrcnMhKxtgDx643y7TlV4iXclagG7H4cefliY11nRWrmdEw5seIjNMoj99xYieMeT/VgwA+0j9
 ldb9xYJQJOKcc9roXlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_02,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210144
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

On Tue, Jul 21, 2026 at 12:40:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] A race condition between SMEM probing and `qcom_ubwc_config_get_data()` can cause the driver to bypass probe deferral, incorrectly fall back to default UBWC data, and return mismatched configurations to concurrent callers.
> - [Low] Missing Kconfig dependency on QCOM_SMEM causes linker errors when QCOM_UBWC_CONFIG is selected but QCOM_SMEM is disabled or built as a module.
> --
> 
> > @@ -178,9 +195,30 @@ const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > -	return data;
> > +	hbb = qcom_smem_dram_get_hbb();
> 
> [Severity: High]
> Can a race condition occur between SMEM probing and this function, causing
> it to bypass probe deferral and use incorrect default data?
> 
> In drivers/soc/qcom/smem.c:qcom_smem_probe(), the global __smem pointer is
> published before the DRAM data is populated:
> 
> drivers/soc/qcom/smem.c:qcom_smem_probe() {
>     ...
>     __smem = smem;
>     ...
>     smem->debugfs_dir = smem_dram_parse(smem->dev);
>     ...
> }
> 
> If a driver calls qcom_ubwc_config_get_data() concurrently during this
> window, qcom_smem_is_available() would return true, but
> qcom_smem_dram_get_hbb() would return -ENODATA because __dram is not
> populated yet.

I think this must be addressed, the DRAM data should be parsed before
setting __semem pointer.


-- 
With best wishes
Dmitry
