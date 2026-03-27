Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CAF10F284F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7084410EEC6;
	Fri, 27 Mar 2026 16:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fm91FqCa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OTIUankY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665CB10EEC4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:57:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhD9F3084542
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t6pviqOdIKEhSum81CYcBUVYB3zHMvsVXBKXtjEQndo=; b=Fm91FqCamBWxrBbu
 pCCByu9r7XjSSEMUy0QRs2xOozqPy/7pYdxt0oSzrJmxWzzI11qwPXSeKHfSQRlS
 63SXZOef5m4/aFelhlsYE8oxYOh/38oHKO6WA/nWV29isI2l4QF4/UYgrbfO2YfZ
 wVAdiL4KF16s5vwWdAaLN7SYhNVF5T237vo07CBcbPO4eQetHnwABhDTTOgXZ9M5
 7CofNDiDHA9+mBzt9OzFnFddIDD/GF7BS9Xmirrdw7F0QLq4y24y/Mb6E7v77+4x
 du90FodUzb5119MkQpp7isU0JFSuGu24+7jiDBplDkIV2pB14YCL2rFcWBeyvBj8
 vHQRyg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn127dw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:57:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c1030ca85eso2674719eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774630657; x=1775235457;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t6pviqOdIKEhSum81CYcBUVYB3zHMvsVXBKXtjEQndo=;
 b=OTIUankYInwGFPdygUUS7Mr37U4R8yJ5YLXTLWpUwT/cmgQbOPXqwq5OWpvPp/YuvX
 lX/XSuiclnZ6rYj8e6Y++wcjf+5/ztgJhuvbJiLkkeyEGi9Ch10vNDTUuI9J3yAfeLNI
 uhN3UQLj3RxsH52LWbYRa9Hr5KCbjI4VRIPRClEEgiXeQ/C+beLTW1OEEX5bRQ2d8F3k
 xwI97dB8Snzdy7yQ5vj+sHYnQYCURFLmP3Z/+9Y4itfPx59L/KAZjYOZWpx6NgrMV84L
 ERXAFUgdNgNQfCfdMHH4IdNKBnqAL+uiAhMSynY5QPYX9YQfEZ3R/Tjpxh48eZG+7HoO
 X2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630657; x=1775235457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6pviqOdIKEhSum81CYcBUVYB3zHMvsVXBKXtjEQndo=;
 b=hdclkG0tbAC2PI17rMzV0dBVpr4U8tSsG6Byim/QmHBgRBEWScRyWA5DfLTZuIS4Yt
 qI5N2yCBYnmj2ueO6l/QvBL7671E9wqAlxhY2F99xl9wW7Bt5I+Qp2+EG6TkuHNUm968
 QyVC8P40pfyh5PY6CV+PmxMZYT6i3JXAWfLsBtUlrBcDKwxJD6dpJ+NwBOjJxDRxzM5f
 1u5g+X38X5GOqHpjJOUI2nIYa77sXigop629s62i5WvVMdNGyKoHB2nRPtb0ZRik5+/v
 Bp+vhNb7RkV59mhbkFJCKAvXgexJEBiDxWHm8xho70jjuas3lmq73AXyZI8xmGTrsmai
 +QZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6tQGj6WgXt/75FbeNB/4vhiGylXzHk9NOrhsyF0dKgeCrhMPBF3l2smegIMvrSQyaZT457D8QJJk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFY9MlhlMFmbXJQXflqh1ZsBUFAPvNQ7jrcKyjOs6ZHVRwZsRE
 YpmFTUpeNYRttig/uwUPPogWOIU0BK9+tCowJCq3nlLGMugoMcmKCL3jgppW6Mlzl/PR1Cox3af
 dhwJ0DpMjEm8F8s4nR5dAlLscFBXs/TedlDqKDbCNfXIE9+noZ95CzbyD9A/XdrDAym17osA=
X-Gm-Gg: ATEYQzz9sL2bzuAJzyLT+fSloIP7EPcD2QvCxjK1CzOc3QmRImgsstLFAwby0gnDJh4
 mloFqVZUSEE8r5FNZr5BgHoOWDg1ExHNVe390H84POaCMNjyCyBRI26X2HwONDkf9qRYJUaCtJt
 kiv/c6a26T/0+Jx+6DS/+91ovYUOR4ys/aoENcVUuLXOrjsUFTqtQfPkBKKKvaX5rsJPS/FlMad
 5kzBPl6leAhz9JMot4gPApo7XTupj4ivVtK+nA7eHbjBwk6WLzr3lpFs94oW8zu9SWul+Upc+is
 5unfOReW2Jb3rREleLoK8hpwKiic7BQUZ4Q4atVCk493HZO+326Yrsv7DTBuu7HqpVApJLLSOTK
 JfyLNzOVfyZCz4yHCDvHwkpb2SC57oO/WRuamrdi/aesNrQI1XHrpmeSW5fOuy/lG3Wkmeps+2m
 c=
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73df with SMTP id
 5a478bee46e88-2c185e90d4bmr2003100eec.30.1774630657483; 
 Fri, 27 Mar 2026 09:57:37 -0700 (PDT)
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73df with SMTP id
 5a478bee46e88-2c185e90d4bmr2003053eec.30.1774630656107; 
 Fri, 27 Mar 2026 09:57:36 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ed9c073sm5517723eec.18.2026.03.27.09.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:57:35 -0700 (PDT)
Message-ID: <55e9ad45-ef7e-466e-89f8-d2d1d0493d54@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:57:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Update copyright headers to yearless format
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251223172425.2283978-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251223172425.2283978-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExNyBTYWx0ZWRfX0DIoxbMPNzwz
 z+Q7RCGasFNTPaPt/XYFbubpxLMV85T0orKWJDAxMSyJzQ363q3NeLioFh9KaMeHV3vBVF1F9tD
 VFBvmuNyfCUT6qKYnAzwxumn4PCrTh67M6Mvbj3h5zVnk8xoCA1WcFj62r3/3fok2tOpXFg85We
 ZS0sfFJl8O3DXem9T46OyilUNE0YDuHl2gdzaM7XrvTMPbqcq+0dyg1WZNpnK3KF5pHWxMxl7Bo
 Za+thBi62oGSqcdUNfyM06vDpUVgSgZ5aNueZZWVggFzrFNYiaz8Iew1Yz40XOPxLWi2rnk57qk
 2oXZjOGTENuZLzazr6rrBsCXyOgcAZt0jgHH/4+SaNxzxqr50iqmBKPIXdlxPmctOQHOFdxhVlG
 F28DulJkUK/nY1LIiNVXSiR7dhdkUw3//iyukqPAJgaxaqrf9OSjK5WxRqI5m2CbWaOKNmKDp3F
 bw8jddj8WVPWoMTKjLQ==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c6b702 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IWQDTU_h8YkQ2KHlyqYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: VAt9lOMXdHkZfR3PswWBC_WIrPjgKLBz
X-Proofpoint-GUID: VAt9lOMXdHkZfR3PswWBC_WIrPjgKLBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270117
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

On 12/23/2025 10:24 AM, Youssef Samir wrote:
> From: Zack McKevitt <zmckevit@qti.qualcomm.com>
> 
> Update copyright headers in accordance with Qualcomm's current
> legal policy.
> 
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
