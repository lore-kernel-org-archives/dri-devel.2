Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D43CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FEF10F15A;
	Thu, 25 Jun 2026 07:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gL1VEv14";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LxOizU7r";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A3A10E1B3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:41:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P6glMH1527031
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V4N3Gga+dK+IdPbI/DXsNqi9huRn9GF1tNNYDx1OsWY=; b=gL1VEv14I52SGICN
 PEIaFnfDGXje94zYIL+3fgzGSekcPBv1y059At8J07o+I1N12qdAIbVs6VwiU89u
 Lp5y1JFYdpM9hWY7eajP/gh1EjndQAI4KlE0Vqw06Q0/pjBl7FXM9cqmbzwjpH/A
 +OdUiT7eLwmt4yQzuwQUKw5Yob1EUmneaJHbNbrBWKYahyzd8X5n0VuUpDA/9d5M
 tms288tueD39Zhm2yEaHtTTqLkcS+qGDaywy4Sp1ZtmuzGTPNw9cvl1MH7XtP9e5
 cx2JNAjUMIEjyVbWV/tFxR0I4QMrIlFDbYMSIwJl2xeqIRpI2phl0yrciG1lXkSC
 Ajn06w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8r764-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:40:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9229581de9eso44236785a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782373258; x=1782978058;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V4N3Gga+dK+IdPbI/DXsNqi9huRn9GF1tNNYDx1OsWY=;
 b=LxOizU7r44pQYdUlwgnoCxSb50b3iYRyOcBiT3rdywcc00Yws9DxrrEwLpwe85Z6us
 QAIN6Bk9GKqQDBKKlQfdbaffy/lZFdeU2a/W4zpn56V/efpUP/b5KZggZf3mtMB1nzK5
 vGPDftfO0UAwVs3uGQXye95r9+XA3aVSG+0UZjJzlP1gx6xQ8+m4h74+FtkHziI5K8Ve
 PzhoO7ZPegEnXF7ywornnnww6QZ9dbIBGuwaljsXAUj9kb7dE4rPuP4xMsyKwdtcBhg+
 99Gm5QJcT9HM3edRqKLrSwZzX090YmrKdWe08GoAKtaz+qUkDkwBkGDLz1nEnOFwPHxL
 1Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782373258; x=1782978058;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V4N3Gga+dK+IdPbI/DXsNqi9huRn9GF1tNNYDx1OsWY=;
 b=r03fgyT4BWN3r/p4xcOBeQV0v3r+xBxeMZjQhymqyd0DpmZ+ltUbagk1xAQRK+mliW
 Xzmsm1wUcU02fdWi7QGNTfj6Uhn2Yzor8x+DkMMnra+GQ5pvGu1MEXZwoxs5/+/h8UfK
 Da2QI5UhKXoMhhrqP4CDODv4Gnv+SRlce00RsjTe4qX8jcwIzq/20oPuEg0AN4ICEzwE
 UiwX/UfKA/0toivJD7SGsJT0jXlkRhAvNt88RG3O87we3aYwcwB6fKUAkSVIRo+rVFcL
 M0CCrBOqNWc3bNFbb1fYSRQoNLqohwPdIjodH0sDgTfmXwojJDVHQARluTQdzCDwk92j
 +OcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eYFvS0qxkWukfFgkmU7IG3UYr7dGUwGtXusdLuCNRurjezS5cJP03+9AAA5/j0sDg+yRaidHoHz8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFmQrJr3PqwprqCyCt5ApSN+Kle1CdKl6S4begm7H1ga2OmdRy
 ZmNmFO9TVx73AoQ85V8jADy26RGKzYxbh/BhZAfvOVsHI95CajqlAwdlA2+ISLPaQsz4nUmeeX9
 46t5fhl/eo+3MHM+9m93CbCdQK8HyKId3pQMyPC6aSFBg+c5HUPBdTwx5REhfFHef9cf7/+s=
X-Gm-Gg: AfdE7clYd0BRp6XLqfUAHcGctfBdEF/9HJagEs/u2Nr2eA3zoeEc9BH4eCTvHGaZcvc
 I1E8qtshpFR+08AerP5j+7wLgCeRccX/CQWaP1aIwjun84tuynuFBChL9HqYT5EFyJGkLrSQ1Mp
 1jT2EdZsyyethof/+SLMNcbKnZq0l4onyUFShM/S86ZrzeK/e/0QcOlU0mTmsHaSrbC5GgvG0W4
 vCWEzgxxHNf8r3QyGoZWaJDzOP5+7sNnGaLhHbVOJ6uCmSUzAg+UsOdpxXyAds0jRosQ7XKvgk7
 XAPdYNfnuLWgdUnibQqiCZKZpm8+urB3ZT2EUy9Kc4qWoYH2TYZ+6h3ie7oAmiux9aJUQkNceWK
 aqXvQSY6jqaC8vu6DI4RYJqo5YV+FWIDq7cw=
X-Received: by 2002:a05:620a:8807:b0:920:798b:e290 with SMTP id
 af79cd13be357-9293ddae942mr101792185a.7.1782373257728; 
 Thu, 25 Jun 2026 00:40:57 -0700 (PDT)
X-Received: by 2002:a05:620a:8807:b0:920:798b:e290 with SMTP id
 af79cd13be357-9293ddae942mr101789585a.7.1782373257172; 
 Thu, 25 Jun 2026 00:40:57 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbba8b61sm116339766b.4.2026.06.25.00.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 00:40:56 -0700 (PDT)
Message-ID: <c1984f80-f8a8-4ee2-a087-c49ad3ad1e39@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260624192700.5388-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfX67l+7Ug+Z/zY
 skOtyUpp7GVz/KwPJ5qBu74Gp15PUCmkb6rVSi2ly8Tu/Ylq5mITmuuQR6RKknOHq59Yk2TLp/9
 CLOlaHRkPhoz30IpvzIcukWixwt1xHA=
X-Proofpoint-GUID: d6QxT4X9PllbdAQjoQ1_TFMSWfqsGn32
X-Proofpoint-ORIG-GUID: d6QxT4X9PllbdAQjoQ1_TFMSWfqsGn32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfXzT3biHkfSkC9
 qDLHbNowjJv4VojcRWMPJxaY21PBSE39T4Fix3n8zjXhkSRdck0adphhyaRFltEGEu88uA/OGCJ
 /VO52U+tjo1LFQC32OQtqfSPQZPZiNXLgLkmHrtnYXV9WUgJbN160Xm0TYyrFidrUhBOMOAcSDo
 KnzSD9Ir+PkLgSsQjr1LAoLDxT+h1069+D3B6zr3xnFj925/qOGODNfy/XwgLF9vgaus1cpeRF1
 jzawNmqHraMluIoNrGDbgdmw2l5FGCttFDV+Iku7HmZNSVwVEy1RXUUSBJ/dOjV2eJEwVqJnFuX
 IdaRU724e4Y1+Knwi4BrXGF+b3EwgsRA7/3/4LaBjal+i8sNAJiKgWeiGCusKDaQmuWaucSGbHQ
 E+Wece8HEBvULK9Mz1rlUAB7WIRu8e5AJxN8BxwSJTy1/JaHVhK8mOOU+SQvko9ZOoj1BKlAOet
 oGF2QNh07EzvYm3Ov/A==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3cdb8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=nLcEm9eC-BXa-18sqisA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250065
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

On 6/24/26 9:27 PM, Yousef Alhouseen wrote:
> fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
> is removed, but it does not release the send references taken before each
> request was submitted. Those references normally disappear only when a DSP
> reply arrives, which cannot be relied on after endpoint removal.
> 
> Walk the channel IDR during removal, mark in-flight contexts completed,
> and schedule the send-reference put while waking waiters with -EPIPE. This
> prevents disconnected channels from pinning invoke contexts indefinitely.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---

You sent ~10 patches to fastrpc as separate threads, do they have
any sort of co-dependence? Can they be applied in random order?

Generally if your changes are even vaguely related, it's best to
send them in a single series, if only to reduce the possibility of
a merge conflict

Konrad
