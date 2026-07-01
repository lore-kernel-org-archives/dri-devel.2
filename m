Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7143C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540B910EF04;
	Wed,  1 Jul 2026 11:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvcifFMp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MyB3D/Li";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5D910EF04
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:35:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8tDp762327
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 11:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=; b=XvcifFMp5onnzU5V
 d/UFBCw4gg/lpJKmlaAWt8cRkCWPdPpcngQnhYgYzWqxvbXW4J+SNMjLb+MsmDJy
 djnlC9mQXbuxA0uat5oo983eh4zoW442GfzvSn5BwT54oxWxUbbad0HLmoisdzKL
 R1Tn/5y5uo5cd9nhl/UHueQdGW4r+f7vMoz95ChIKoH7BjjmjzDAM3Gmb0lpvziK
 cWhKO21LoVoSf5pLoOp0aBGScaxVwFaeJF4u8qyiYBtSUZ7Fb7R/sMShYO7gKeDo
 9zkkvn2NOVeKKYo+e64XUG/+jJlsF8wyb+WCc3U9a+4KMSme3Tbo+wZSdRsVF2OL
 cml/wg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd0cv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:35:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so835197a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782905746; x=1783510546;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=;
 b=MyB3D/LieGsMjTQnqit9mTwna9b2bVHcyN90xuKtC4T7Fq51d/6lI2yG2pH4VW4EGZ
 opmtnRPCdihvc1sgTkcw+yokMg1rOTJIOliLmKvZoBwUg4ILXz0YoU5VSMixqhFL92QV
 d5c0ge9ms3uCp98RCmDiUhI3Wl/qw5hzFXK6DfRvIetETHcIZwdlv7fvGoLagKf0winM
 a2QGTXc9TTdeuAI+Msir85Jm104pEr8xAvheirPQvlMujCOhZpKIjgfHpCNsuKBhAdP0
 ETiA+gmYZ6yIwOw+Z8tUoX7l7sSy9swYT4KWZXqDDFRFyslVuOqtPL+zbEDZIjhjHF8+
 tnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782905746; x=1783510546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkuArwX3HTlRI2MmPQcqM4DBytZZqydkRSJiGkAnDt4=;
 b=b69Ooih6lUp2wfbpK4O+7FakcIo/KLw6tmyD6u4eZFWbPs+G3/zL725O5n3rXRy4qT
 slNi17+NN1fju2ktukzHAoDrk3K4bmfrEInshS1hlqU49lyhlFjmSOY3Ll6lGnkyAKyi
 ReCctUAOOLRAA26uskVE8lp70ioJAUGsczO4F9QgGPDWoqhDTklzSxqQ+rVjrj42QFip
 W8Nnw55UT1dnTAXFqiM0F36cp++rZFirxdc56hR9zMstUJVN7C+YjUsMWv4eonjGg7N1
 7qw/uslFgYGrOTSAlbJ+Qu+ETQnwyIIFcwwj8kDc+wRxIQ4LPzNfB+YZGdRJ1fjDJn9c
 8uIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGGQFdku0+4q9igCAKvSLdu+sKmMMYrhlVqB/qWO1y1lnfJJcb8i6VIcE+wMypTxt5t0Q2bGTNF7U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9DJ/GTzx44/4a94X9Qma9E4P5McJs8gFEDIhYhWFzPRlUYQaS
 cjaheSEf8X7lSM/JPLG7xx4YqA+KtWrQyWZUO80HfKYoPsT4hDdV/mS56xLGocv3Sie+U9xHuHn
 dc4oRtlKAiY/r4jYHDr03eLmnB01nPg874btGjyz3Ki26zkVMZIsyliFIJ5hFCkw3RLATLxI=
X-Gm-Gg: AfdE7ckfaBgxTrLHMNLDAhUooGx+/qP96UFQN03uK2wJOTHHwBOu8cO+Z2uMqeegWjA
 wDf1lyBQoQrAmUwNzCstNBAY9nco1LceGNTl6JdrGWtBG2V4AfX04PibNcPLhAShsPl5sDIxQiE
 zXIROycyRUKE5uqdeMojD5Ye+SREDtdrhd6R/DrXjnUecNX6asx3oeDNuhcllECVuSSIpa/3tBd
 nsWVSj4ysVQQSCtLXh+Z+ytyvNKj6h0wB7B33KRAeMwA36BTIS084rly72+4/IMr4fKVALWcHi0
 MhSVvgZ7E3dd30Aqzlh8QTXN5NrFCnD89Xod5QwGx1BXrKXL0St5EehNCS1q01rNUZM4k5k9S8h
 U3K2eytCGh5fRWeX1llOFlmjPJ4p8zRrs4etZvt2Ltg==
X-Received: by 2002:a17:90b:4ace:b0:37f:9ce1:cdad with SMTP id
 98e67ed59e1d1-380aa1d944fmr1315964a91.27.1782905746502; 
 Wed, 01 Jul 2026 04:35:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4ace:b0:37f:9ce1:cdad with SMTP id
 98e67ed59e1d1-380aa1d944fmr1315941a91.27.1782905746045; 
 Wed, 01 Jul 2026 04:35:46 -0700 (PDT)
Received: from [10.206.103.168] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d47dd4sm1725623a91.1.2026.07.01.04.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 04:35:45 -0700 (PDT)
Message-ID: <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:05:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: Eddie Lin <eddie.lin@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a44fb93 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=-sgLQT9tILotkD796yYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 4afZ6hMqNr6BdsfPN-qlNoacz8TmfwGD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEyMiBTYWx0ZWRfX11mxCQ3HSfYg
 +QqH+K22Lj0gMXNi1YPqmjhoHJz+w+8FDvOamOLt6vXyvW43SBTXckIWqHb2JbYrbYT3Cr/tlsR
 ErG5KU0CmUoj2jzZA597GhbbofgOwlQ=
X-Proofpoint-GUID: 4afZ6hMqNr6BdsfPN-qlNoacz8TmfwGD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEyMiBTYWx0ZWRfX6SAlcCmx0OgB
 /goD+s7nfmhnwX/cdw4ll/T13kmyUnppJ6Vx+z/EQEgYztiNOyWgxAOchLu0HiNLe42kRzugG3N
 gJ5HGVKNC3GbDhAGrnXnpLwqeVhgJ7Sq+sK4V9k2W7TcwT1BV/BBXi3nq9LRuF8V2DcDOsLEO7m
 V07QhIdB0jaNa8kfaCC14JlkqrjkeWka/tVClWxUN69aWI3dgbbhdTTMWE4N80snaBK6g8fgPNM
 MR5M6RofBr7+xDWl215DeV1cubmeIdqVR7ace4Q55DfG1TWuSFRsV5L4ITIsEEXWH97WrY8y7uL
 wSFTxYcwqtHSYptEsmwWFZ+FD1r11pIMF8fYzmyJfSErvNPw8ObT/imlvogyBmS1YsL85Cfo6f9
 yRHT3l7SEyAQZlqmiITEcWpI0dom/ipyvRa3k0dzcfPDQU/Mx4xGojckDuMJmWDQ+Afz6ywPjQJ
 Q7MGPJ526Dd4KW6MMsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010122
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

On 17-06-2026 16:39, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> ---
> This patch fixes a memory leak in the FastRPC driver by destroying the
> IDR associated with the channel context during cleanup.
Looks to be duplicate information. Please remove this.> ---
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
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> 
> Best regards,
> --  
> Eddie Lin <eddie.lin@oss.qualcomm.com>
> 

