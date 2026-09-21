Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F20DC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2BD10E1F7;
	Mon, 21 Sep 2026 11:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8W0TYh/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YaUS8QzG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43AA010E1F7
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:06:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeCZv837943
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=; b=m8W0TYh/d0uyebaF
 /H4rugJm9UHLtaks3QckssiAtyDNBN4VuiPevXR9Djr6KzlTqNqN94dM756RqGU2
 NScRNU1R8rw6V6EHlfnol+na3tTdTl+izaV+EApchomVaHSztCRB2Gr/yfhGRdnX
 Iz1Bxp3qr3rMUteI4SEwqtGKT37Qq1B4D4Fs+UTQiElzZQ3vjCBQAZXj5XYxb/3G
 bkbPenBi2YQVunoAyv1n8iI4d+obL17oNt7c5GmCUW68PrvRGh0SxpJtsQVzKsjI
 Qa7UIn7jbSnyIy5kiKVrb9zhBs1CubhRxIdm9WvcSkTT/EP958vHElgSm5C8lIy5
 1aH33A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtwf5hfyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:06:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c66ec39d8cso81914e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789988792; x=1790593592;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=;
 b=YaUS8QzGXj0BUo3w9ueFdWe1aKR8os671ykQGYqtkZIGXxEp3xzaAzBQi2F/n/sJFN
 Dua+3aZmLG66AlCPthhGJj0oRg24vZBniybi/Q2YK2K2/CTuHLGgGInw029u3YqaeZ0t
 hgH7Wew1aUgQzjYPDdPRwTdJUaDglCeCsI011uHOrRfNYTS0VmvDBCDrrimtXf5n6tPo
 uCRFz0auD/eK5kMBNCxGAqW4hXfGajk/0jkP8CJaLKN8KcTdOHQIojml1hXgl7RC/plX
 Nqy/Si3+y9dUNO4Vrqvf2554r63ZvmKwEAd0cwrX3FnEuxd4nl/mBvG89QguYt2cbHgR
 2zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789988792; x=1790593592;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=;
 b=XgT/XdcX14MAY0IzrmR9BPYAbdQz2uvOVCzEEM/M3gaQFmSGckAsqGcA3HnE4kUWTe
 ElHg6Js5guLcwkywTr7+mendj5VPvO0LJHp0HpsCFCDQMYhjXgSPtJnBK9fvEtuhMIdb
 zpFdhbFp8YpVxSiKr15+KEhGbaD3tPFsWC1wuymaYLQZM4FW/vG4gDnjKbcMsmVdk6b3
 ERTnm0nHPq0jum1PKCRwKL/F9Q5C96QRD0b0TP7MzF7+xnYCpV63NoFgd7TIg+NOclv0
 DSIPRfSq7Sf+lglF4SwBiQNyXC2iyol+7iVy5cTSkCekGKL0C4+GxqfRfkmiFTIxmMwS
 ZNOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUGIfR9fWxtOU5hTh0VLx5Vsv4en1fRBu68QMgSmd3K/zmu50dj7jnFeBG7uWPU9Zskf95wJ6rBhE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntxL1l9vKOn0fVIBq8wZdLn79zu38dbhkLfYHIm9MlGz2iRwWV
 h1catZ57K2BAcqeHy+XNmq7T+VNh48+Sx/YeVWcJnA5uQwLHyvs8vqwzHawcSA/YUHThgfzzXDb
 H/x2cjSUharN8/Q3/iObD9QDKACM+CkUL7STWafE0cD4lrn63ycW1qrcBidV6jzPJJhHY+v0=
X-Gm-Gg: AYBFou2TPJMjR0nqc4JrAFVeGdihGAWQS2zf87BYW/at821jJtocrtjuQ0ff06OxubB
 G4cZRFwloPsHUTQwwdIE25tPljmhyEuDGFbmEHf0eDgLjP+DfpTJKrxA9h60t88/fpl68XPvJBb
 K3tfSpyApSTkzn0qJn/Aa/zimCOVzWDUjHIUFxpG3QDoioye/NxSoLfSZ8wQ+f4KTlAEvLwGgpi
 CPN19ObkadlAg/hR/hnlinCPiNm/OOH6ggsG2M14luCZ4Nswm3kcMGyMpcBcotDaCyx+ZuKv0nL
 09hWMdFElisx4aAmmmlMwfjvIP8MhCnjIPo1zzik8MV+lnu+RuL2pGF6sKq9MW+GGq95wOFfOn7
 gB0VLaS75ETR1148FGWvGjw==
X-Received: by 2002:a05:6122:35c1:b0:5bf:b91f:3bb5 with SMTP id
 71dfb90a1353d-5c9bc3b53e6mr3524552e0c.2.1789988792556; 
 Mon, 21 Sep 2026 04:06:32 -0700 (PDT)
X-Received: by 2002:a05:6122:35c1:b0:5bf:b91f:3bb5 with SMTP id
 71dfb90a1353d-5c9bc3b53e6mr3524484e0c.2.1789988792144; 
 Mon, 21 Sep 2026 04:06:32 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67e1b7e1sm3810951a12.26.2026.09.21.04.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 04:06:31 -0700 (PDT)
Message-ID: <8204dd54-d282-4303-85fb-d5408cc0b4b2@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in wled_remove()
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 stable@vger.kernel.org
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SJLXx+vH c=1 sm=1 tr=0 ts=6ab10fb9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z8QxmeLbveigHahU524A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: xfnrDgCp0ZieIvH96X-aT3N4CEb2-6t6
X-Proofpoint-ORIG-GUID: xfnrDgCp0ZieIvH96X-aT3N4CEb2-6t6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX5MI1snqZHZzB
 jLkQMiqkSf2xu8SvlHEay42YqB6KEYoz+GQ345OitW7oziouYq6JveBjDwwWJH2M3coGH2UxdIf
 3KaeEwducd0C+JrVv1YdpHlcx3Uyco8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX0ddUERUmXjH+
 jjs8bm3rCuxaysnLTCOcozokVllbQirc44UT6siy1x9Z2LstVAm+iVPsIwoIIBIiZ5GdOYHlk8/
 A7M1KkA3jYtfwFBTPQvbvSmBGBRJmNULXOm1P7M87NvAOEG5Ppom8vqq3BBK/QDb65gJS0jlpV8
 5lZ63oNIG2B7oyh7X5kpewhbbeTxjrlxG5IvYHJ1hWiDtb3bs1RcIJYW6pzTugHpANNbcueX2yk
 WSD2VQj6jqGP4UqNbkHXj016y8YfbosIuNs9H1cjnoCUIeBDd/0U/DB2AwUI31J+qks7kD6m0er
 mEO0WaAxqn+USySqoKzY2dupJHJqLtRUTgAbBveguG1iRgUYr9TYZ2a4lrmyKXoiHekXAxr0o9B
 s2ph9CZjTpadc+QFleKer1kRI5MbReer3CN3eNkNtXakJUbVIyfY8ph2jrYmhnsxVG0P6IikE0g
 EI8MsGsOtQTfOR5uUrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210160
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

On 9/21/26 12:46 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_probe() doesn't set the driver data for the platform device.
> As a result, platform_get_drvdata() in wled_remove() will return NULL,
> and the first dereference of it crashes on unbind.
> 
> Set the platform device driver data in wled_probe().
> 
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
