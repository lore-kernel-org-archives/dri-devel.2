Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92B7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEB310E415;
	Thu,  2 Jul 2026 03:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxvElt0P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHCgPGj4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CF410E415
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 03:56:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KerW3049659
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 03:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=; b=LxvElt0PClbHvIT6
 I6Oe6j/6I8KscN9uBlnZSAE0UEWZXdUOTcDsM3IrrEjmzv+ufaITyiDTJPdMP4B4
 jiI611AEMKx685j67G2/WbUzKe8GqZRdmOFh57Ld8mlv7Wq0vpDZDEoAp/Uz/IjN
 FXKUn0wjTDxNMLVJFtM4LQEXuEf+3k58IZy1zD/g9rm/5q1io68uTvyciptzurKh
 4GcPhP4MMOR2FD6Y3R7x5SXctiS9aLdIVipAFUS6/uO2fe+BW743wBbI2q1hxX4E
 kWTl7on5YkG3tRyf4ergEAOBG4XAYea8o9Mgqmeup1+J0I9OsmbKYw8MDmQPwRvW
 OTSNaw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541tt6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 03:56:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37fc66ee6a4so2221429a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782964606; x=1783569406;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=;
 b=RHCgPGj4HBzdV9uVFxDGBdcfVEsGHirHzJvM+02kJsxysPX2U1i3uWlw4SOuXSLR1F
 mrn+nmbS3fHyokPiFnEe4QLN7GN0zSSAL2J2bAjWZtjM4dooHR5jioMqM97Ndgty3Ek1
 Y2vpLIU/6wT0pSwTG4zGd7aB6oCnatBXD0nLKgUnx2S9qt9D2liSeJ8gL3RPTzfcQ+I9
 L/KAEmIsT6lFjFmcnL1twVt3Yjd/Vk1g8QfhBh2nZdOFu7bCut+qM4Tv9EU1dfFJI2V/
 oKBj06llZtTeGq3ilo5uEDNpe8jlrwMgm0LbcJFccvKBO2iQGkEBYfqkSTWWa4tpye7P
 HNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782964606; x=1783569406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ovteoajCMGXH3GIr0qzJfxb/mOrkQymP//Bqyef78LE=;
 b=DJGYvSP1CfMTKBHAI9p8D4p2lHEhvwhjg9tNHU0FwKjFMpOhpCbmQ8AnC/MK2lWhpD
 OLrGFm6dU+2ALIvhQ1enzeqU4Zow7c+cjYJORJvROGi5saDINA+rf0XP2R2MB1TxZ1eJ
 hgZNFnLwY9pah0lQO4+dAwED6T+zF9Tvcb1nWuBs8JPQuzXbHsOU4hn4YFpc1GW43RgI
 kAGaHICFWlIk9AiEpyBWMji/ro1D26nHGpUMJVWWe8lv+g0y0AmYHmxa/h8G7UbouShr
 Mytm2Fs4XDSMYTYezngEvH2vq1pOK80AAvdlMYtXJPLzN2+wbDCOnLtYna33zEK/peEH
 ahzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0lsTkU8ORT7JEUqHH3cd1mj8rOpXagLvNvOI59FcWagyxLTfxXrkGBfQTzqULP+9KToi7OKJLRlI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoGsQshDui6e9KIxPunx6btRb85kqL/V4Ow5lvBpK2piTWui0d
 KTINtzCNWdnn+2eZNEyZksBB1eXWyV7auE3JBfSiWN8QX53WUJZA3d4hM+tI/QMLa2UGmmuQkQn
 HlBpXd4K4LwSnyQxcjEiCUsJna8gK7+AyqYfUeS4Hlw/0Uo2m+xm7dGcRCjTs5asW0AYB/MI=
X-Gm-Gg: AfdE7cmQVQ+DHlyxF+3QxXwgAsJfUISPwlnapDo4xHTjlWh4rygWK+sCMaavWmNVKl/
 mrTorQfmlG8mhdwt9FkGd8a8TEfR/lKXUCxBdvQRmW0Se1/e9saK9BsW1PGgHUP9QZ0nvq5mZU5
 /n8RtijmJDGKPlo2+RuxxhkAztsvBeibip7iV90L9mttDU5OzYD/VWbKA7hYVu8xm54ScCCEKSD
 HweYBKAT/rQ/STcMCG8nX7Pg2BGc44xKAn3DnUd4Vivq8HYR9HJBF+s5DT5+7dS6dsMP5aBS+8P
 KmU91xYyXssMC9bWU0an/fCDzxrLg3TUW7I9CKTx0HJDdiGejxgE6GdqibfM4tHgjdggCS2nrH3
 Bzi4kq4Yn+KoxuabwJJ53BMBuJch3Hzv5gXlfiLZ9
X-Received: by 2002:a17:90b:2f8d:b0:36d:8e6f:8d9e with SMTP id
 98e67ed59e1d1-380ba941590mr3202615a91.20.1782964605843; 
 Wed, 01 Jul 2026 20:56:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8d:b0:36d:8e6f:8d9e with SMTP id
 98e67ed59e1d1-380ba941590mr3202598a91.20.1782964605403; 
 Wed, 01 Jul 2026 20:56:45 -0700 (PDT)
Received: from [10.204.78.220] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm3901449eec.22.2026.07.01.20.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 20:56:44 -0700 (PDT)
Message-ID: <e0312267-5ea3-4ec1-9154-2f5c0546d60d@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 09:26:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: Eddie Lin <eddie.lin@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dCbPAg0aanxgHXPX0aY3U0xIgWd48LyZ
X-Proofpoint-ORIG-GUID: dCbPAg0aanxgHXPX0aY3U0xIgWd48LyZ
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a45e17e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-sgLQT9tILotkD796yYA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNSBTYWx0ZWRfX1bYitqzt3NCH
 46nSXvkG4mGEpbFf9MPZB9JcCmhmSAyxEt5CcGCA53JzSDIA+4B2obFzABvblLDNCnkiwjBQx7z
 1COafRCPZO2vKXwH0Oclroy6WW2JflMxu9ymK8knCflf2/tEJti5djFVh14wUNqWpqG9VvrNR5h
 pOsuTc9WHAqMTKXvGinskY+SK1xv7ossuSnBKHGkU2Z9BB5Cl34BtPdWWwv7RNqCbRy5amDmot+
 UCaxzMWOf0bndSksOXJ0CcafC8/8sfFes3LbYK38AZK7Vnk55GtKcsRQqpQtBXobtiIA1opmnKL
 lgMPJwt/HqikLkORCWkmFwn48abzCK5enE433nSOcVCBAaYzFgN47w6m88CMPvadcX3YhdLIN3r
 r8got5DreksgwyZFirhVQhHoo+uzFw9igroMMrPwniIl7x5Dcj51B1Ey+YaK0QW09F66pVSMfys
 HBYo4JfU1ldnMwTEDkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNSBTYWx0ZWRfX6pitgYBHgmdh
 Cth1Tkio3XLBEGGeaJaq6IiBLv1joj0jJ4zgBeNOw2SfX1Hqo3RhhyeMXvry0cE2Iqz5UNEmlMg
 m5MG4z9ad729XyIG0byk7yCIAl/bZFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020035
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

On 02-07-2026 07:51, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> ---
> Changes in v3:
> - Remove duplicate description from cover letter.
> - Link to v2: https://patch.msgid.link/20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com
> 
> Changes in v2:
> - Added Fixes tag.
> - Added Cc: stable@vger.kernel.org.
> - Removed duplicate description from cover letter.
> - Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f..7727850e9240 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
>  
>  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
>  
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }
>  
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> 
> Best regards,
> --  
> Eddie Lin <eddie.lin@oss.qualcomm.com>
> 

