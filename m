Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707ECCD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C893C10E05F;
	Mon, 25 May 2026 09:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="abKkV7H6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UC5eVSC1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7408D10E05F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:16:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P9Ed5W079559
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=swGUlrLa5WZl6kGap/pSw0CO
 t52HIv57pADbESN3Ydk=; b=abKkV7H6Fz+QC0xMZhrJJ3CP1pIr//RzFsO5yml9
 wn+H2SLGXR/iMHmZCdzwzzIdSKjtMOM+Mfn7cQSJzvCMlZ3+lF6k/CD/ZjRRxYwu
 M4RftU4PKNSGZA+zYr+BQgcL22+ey9VtYXKencBfHWbBLVeKU0dhoNLQt2AiuHwX
 x6UdgE55kmPJOUVb++VP7vzkvZY8vQkqgp+SiCoxRuvFAcdpP6all8SALn0kpy4D
 qdpBWCuOOMRTDW1ek8lyLMBXL8Bpt6PEW5qLK2CKaONdStPjSWBFWzgctCRs9jHX
 P/2q8TT/vHAefgdCdhz4SHfJ7zpSEOa9873S086jTcyA1w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckma80aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:16:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95fcbf9c0e8so14988390241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779700617; x=1780305417;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=swGUlrLa5WZl6kGap/pSw0COt52HIv57pADbESN3Ydk=;
 b=UC5eVSC1GAtd/bJIVT1CezCZvztMUJHMn0peCTmZOwhrGNEZPvLs6ohoWyeXzHOpEW
 zBIHvvJJ1MiQDnHxV+HNcY9WnQ8BC1toUTfT3qNq8G4HdiVHBQPQTOJlDrbUM1hG+f0h
 B6waVtWic+HkkkrWm0CtnhLOCiRlfH9PhLykuW1vf0g2uTq3G+UM+0ysr14PIzIsE8fO
 3LD8dGPRyCugGp6h4p3LB7UlJ+Luj6oWZ9oSZMOsaBjq1JXiuCY/NIjijQAiATHdBKUR
 XBa2QyfcnNASHGf2LEfaZmbwDPXFus8M4AxGYDzFHIB+TfKA7qUGIVxuAV/8vE0dhizX
 Qb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779700617; x=1780305417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swGUlrLa5WZl6kGap/pSw0COt52HIv57pADbESN3Ydk=;
 b=h+NoMT2czgr0Ynz+c1ntksHJEfVszIM1FPI0U3pNtxGx5UUeSfKFOJVWweU6jiEzu1
 LO8yvP5ZvefgfZd3gRgeDWzlnwZ4hYvxBwPXfH3ZordPx1wrqtWjOZAVeNeExjy7Y9ES
 XcI6QWod1W60uWXzw14YtDvP+QYcUHKG/+/XDH8Ze2t9/FdvmAC0d5rNf2mVc/tVW/+X
 EplBjgqIHWckGuFfQoOPtGJdbeMNxl3LqVpmLMqd+WIRkySMFP7GQuHdiVMeE7w+TFlt
 zHCIC+/6P4kC6cITE8p5+gKI4Cq7KVuPZMZtNt4qnNImIRjB04JToSsAbW78DcngRYX9
 6Pzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nsnA/OwZVdijzPIraxbPmn6rZoIiLJcE/1upOT8ZN3hRkdJHtQ26f3R/MD7lrFgreYzNEMYwRsaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyijxwd4mh9nQhGYor02jzNfrKtj/dGRu5YTQf3SmifvSmvq+yR
 l9FxylKdaN6ynz0Wpad82Ebo9TKOba3HURghTw64aoMcVHEq0VpkIM8ZIWDKajWbJZRpoVbvrgL
 gr0o1qcOWbMvbu+7gOmaHunr0Z4AbZoZu3FoszNHoMlGmpmGhm0w+5qq574DMOPu7/ejVOzE=
X-Gm-Gg: Acq92OGSmEJKQR+ac+QiZTBT8TlTUwNeN7gDamFAojhIeyI+HW2YoG/0Kx9UNDnvVdd
 2xVDmJfpIjv3g7PcFwBIVZ1VFBaP3t4D/U59j+ZyELebyGDzcwG6qVC7A+cSYONp7ZJ24ype7Yc
 fZZSYAwEMHFHw8D55Y8ehw+59je+/RN7jPkq1ehC4xDQAkqlUJJU6D64dWtqPumiwI4pE7ov0B7
 4EMwD4rnaLYRHlG0uJIlmJUKq5Cj652HuKnwhjti15qKReL3EDN201UwStiCJGUVHLWrUYTiObq
 WviOxTzoB/BcIbq3S9uZiUX1kjzGQ2yvZRFyjFDtFweFWZ7R/pIDeTvXfxTyAyeKY2tTJJFM2Id
 7hhRmQBxvSVvRITxv7XV45DUS1iku3TMhdo3titc0A7/mZyGJuPiBK7UnrwF7q0DkgYefRXUS/X
 98UdYEs0AK2Rm0rvAOmFLb5d/zESiMlWai/8c=
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-67c8cba579fmr6903432137.29.1779700616854; 
 Mon, 25 May 2026 02:16:56 -0700 (PDT)
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-67c8cba579fmr6903427137.29.1779700616494; 
 Mon, 25 May 2026 02:16:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32ceb153sm2526918e87.39.2026.05.25.02.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 02:16:55 -0700 (PDT)
Date: Mon, 25 May 2026 12:16:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
Subject: Re: [PATCH v1] misc: fastrpc: fix channel ctx ref leak when session
 alloc fails
Message-ID: <jubkqaefflafx5bfa43ky64y4zwbpmhwrsayh32fyendoplfaz@ih6h6nohp3wb>
References: <20260525085340.2734738-1-anandu.e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525085340.2734738-1-anandu.e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a141389 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MvwZFT3bVuec0MXgCpgA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: E1jR2vmnw7i-bIo0mhVeA9YX7HeOT5m_
X-Proofpoint-GUID: E1jR2vmnw7i-bIo0mhVeA9YX7HeOT5m_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5MyBTYWx0ZWRfX1UUIwP+n8YSS
 eJ7BBasMAkuHHWEAxUHSLKiWu4I5Bvqax75ftMBB033iOkoFmZBiT08MtYSuiNC7qRXFezIJ6YU
 Zyj7Kt5q3p/USMElTCC6GRyr9JMp2CKMrP2ZPioHlHjZZJYIDglo1zIYRjsX9Qnqk9oZS09pCiZ
 BGoSAZRgDiYRSEqXVOAzT4BBAOHRqQsjPQoFujFBp4MC/Ff6T098cNxy4BRYt5ALOSfYGBN6aVi
 dELGj+NTK5swwT3ugiemqBOh479JT0SORz8fjKGS30jYLn++TBiZ5CMZXg4po3Ft6HUO5NA5ONi
 /0UhkeovuEX7XHcdYtbZ7KkHHAlFFiozde0rtebnj956AQGr8KCI1pUhw6FmxEWPEkbpd68roWo
 8jtxqUEr7pnDJL3QyDOL9zuQGdfo0Sifxm5feyjAyDKCWgoUsu1fvi5rZQjowqmtR3G0GzRlTwZ
 P202dbZdxJ2rWNtGwAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250093
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

On Mon, May 25, 2026 at 02:23:40PM +0530, Anandu Krishnan E wrote:
> fastrpc_channel_ctx_get() is called in fastrpc_device_open() before
> fastrpc_session_alloc(). If session alloc fails, the error path
> returns -EBUSY without calling fastrpc_channel_ctx_put(), leaking
> the reference. Fix by adding the missing put.
> 
> Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
> Cc: stable@kernel.org
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
