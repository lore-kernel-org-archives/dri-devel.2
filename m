Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BC4F436BD
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4095F10EA7E;
	Fri, 17 Apr 2026 16:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVxpG0FH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOYaxYk0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6B010EA7E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:42:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4iRL2669985
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W7Nil3ecXcj
 6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=; b=OVxpG0FHfDhisAA84Imu2jNoHrk
 ur50hhXxKLhjankYxhqcY165Zwce30QWhedsWqDIswjE2a5EaT3L0SmPlsjHWrCs
 0Mn7TzIQq3feYCKMoY3pGttWOv+NpbkpEsO8085SOvhfHO131iBOSOwWhq7CFZtK
 3E7Hh8rzM1Aobu2hbrK+RrTuONBfvvS7TTeoy3un07o7WzqHXkIWA2NhxsPYl9aM
 Yan3KlWta8QVZxDnNGTzgsNMrJYyNTyAHf+/8aI15RYv/M39M9P/WVW+IKADDRN0
 Fu8EzldaPBWEhzLNtDfB22k/X8h4RbtCAzXaWNSicGyvSknc3epTidtxOJQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxcu1pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:42:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d5aa81907so19739181cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776444152; x=1777048952;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7Nil3ecXcj6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=;
 b=cOYaxYk0OJrkevwbXXl5G5kyQc15IF6E+Dzut5MIytHbauPZeeOyhOoCPodMgPWudl
 IJFla7431YmcyYx6EayMKspzyutSOTQoxKvYTW1CluUfuM1qWg+X3g0/aMu8GBSh/0my
 5598natoMVkm9dhKdUSMR8+88maEiMNcM911zlQgHwy8DA6f4/aPfvKCNeRZkOr4RZiy
 GiQq+O7i1E3VcvWJGgyTxAPmAoENaB5XG9D05tCAz96LR+tENnoW36e62pMR5MPMHMbA
 Uoq1i2X22E5yFiMU+W3ccG/O5CnrQ3GWYFt/UwVlenMUiv0Vu+gJQ2DMagmqLzvDH8lT
 qlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444152; x=1777048952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7Nil3ecXcj6h98aqBWWZjhPtJLGkI6jnT03x/3dt5s=;
 b=PPL08v6zimGZrL1nj9shfsCuoEnn01rGwUgrmBfmuaxPAoQHOsp2j9eShcYgshEmRZ
 2P5R+VIRKYBjeQdvu3edGajnruTpZc7HGtkEZ6cU0OtdJVutLWdZ3f+xxxkki/Z1Zztb
 i5UEYB0cJQnBqEJypzwzsVCId6E2Y5oF094J1UhBG5gepmMUSn5GzxpxcGZXll/H8T4W
 MD6DEUdmEXNHWSgFLVP9PHVGGPav3Mtx95/Y4YC2LBjTqsprRInKOt1r1Paj+Oe7HOt/
 fN5ZwWf1PRWbLCiqMaV5Qpj48UyDl6zDJht0Q+pDg1kWdRIU0Q0+yW8hGJOduHr/Y93T
 ZsHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ83jqipBSDXdFvnf7+2gMEisD8UIOnJQhUifbUvGJtPFlNakBySeurEJ7RDKOXhkQZCidxfjLbMyTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzasGOytFud7264zHJdPe3gMLHw9XL3QwM3hYHbwi8d+bp8bClN
 E6F8r9BRyoeIHKZRVK22Wx3kZ4BESDcsbpY5ptkhghQKG3cmON6GR8NBd+A9WhunifISjcpkyje
 5Yyc/75J2GdE1YjPm9wllgmGxS95z3wYButMUol6TiyVL7YivxkQiLE0Phmv/EVQ6Es+wYIg=
X-Gm-Gg: AeBDieuQvIB2FFdha17J0fzszwUyKt9Tq04KhHNwUIJFCuF8ObcLaZUzAsDtWoHk4Si
 XvvCRtuhVdjKSnctnkqLtb7SqPlXEUX5qfugVNQCBf7SsHahYyZ3Q+uYU8JDHF455vToY5ryLuf
 bK2YcCjDVenijoCIoJ8LKrCAidd/fW9SjRkKqA0F9rlVr2gSHSvl+Fh9r4Tb2vSXeRhNUn21txo
 uJYUUl59YXKnJUYNezj6jBCCfj70anFSt6Eupkiisz9WVANl8x3BIdjV/prvMd4TU9j7eMktCBm
 wUJotNuZu3ennxAaZYMo4RrAtaQyWCe3mFIAn2bd08DDgXJjy+ngUn3GftIumJPQCxopODL/TTQ
 B2EqQBtkwTNfecsJm8MXPgR991QdmU6QdO/uW1AcvG85Hpt3bHs41G0pcVKzskUuQ/YEXu7Xv
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id
 d75a77b69052e-50e36c8da62mr51569141cf.56.1776444152545; 
 Fri, 17 Apr 2026 09:42:32 -0700 (PDT)
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id
 d75a77b69052e-50e36c8da62mr51568571cf.56.1776444152093; 
 Fri, 17 Apr 2026 09:42:32 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba45553e502sm71796466b.61.2026.04.17.09.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:42:31 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: rosenp@gmail.com
Cc: carl.vanderlip@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 gustavoars@kernel.org, jeff.hugo@oss.qualcomm.com, kees@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, ogabbay@kernel.org
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Fri, 17 Apr 2026 18:42:30 +0200
Message-ID: <20260417164230.3158014-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
References: <20260401220643.12802-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e262f9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=zgiPjhLxNE0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2OCBTYWx0ZWRfXzyTNXclt2BIE
 wyzsJGrC37CK1PhKxQsFVJHG77RbtfuN/oO/YNFjCgkC4fKVG4dY7bJ3EaY2Trw41glf6PfhcAa
 o1rsMLwwO99PI1PKQsw3VlnNRgdJsR5bzdwBE1sFniF5WS6HFuUfY2NRB4z6GSJU7tkqZwZlsl7
 81fgQECC0Yfb/whg+gDrkW2jYG6PZuQowC2LJcivdILgj/kfXCZCQbcpil9F/G2FydZ5RPUplR0
 QG3ngkwnL1t6ies2BffvEVjxTs515JaVWhqetuSMXnjt5+IiZLfDBrJylv2MpERcwvxFOv8t3/Z
 MfH+FNbiKl6uxHlU5jLJgSpIRSwvTPtC6MvTA3EWVMINOVPDt1nqT56esBLduSIItAgcRJ/GKKW
 0D4SN+vugRRq2L1nutpBdKwsLnmKNbfAQ5goUlRX8yM+RN8Sm1Uy/ub7AKHhMAdcD9Yarx6S2XG
 cVeVI9TPq6Dne2GIv/w==
X-Proofpoint-GUID: lPqSQnYvIx3YSlwJOM_M0h6M1PYYsAqg
X-Proofpoint-ORIG-GUID: lPqSQnYvIx3YSlwJOM_M0h6M1PYYsAqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170168
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

On 4/1/2026 11:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
>
I've tested this on AI100 and it works fine.

Tested-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Thanks
- Youssef
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

