Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4FDC54FD4
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AE910E0A1;
	Wed, 29 Jul 2026 20:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XAUsPHGE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H3z/yACT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E4110E0A2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:58:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TKDXYv4044580
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SXSfyuVk7nhwcBFF7oOD5gqIy16PcYgsT0nnHNUvLMM=; b=XAUsPHGErG+uIyOh
 Qppnx6ZlEq26SqFbuOa7mJ4MyQ35FbpgJojUedz/7pgsxAlb9UWoVDeiOQAYcgAa
 XRtJTN91d/p6vfbZNkkT2YKdWIVPoiW34SG5c9s2bY1YhoFejUXxnCEpxnYnDo4L
 zVoUt3T+whGnWYMrD7y6nHQEYxeMAI2/7zSRpk4BxN9O0o2xFdUAtOtJi634menl
 gK1ixuKd8u8sUg76GqsDtgRnQ5gPtLA7TtTyPG/CL7hLWHUzNDUQt/jspktM3ZiV
 yjiuEA9f4fwHGRKvr4aJoLKFOIWlbpsPAVH7PKFC9KUPXzYCT4PlWVDrrQccVWOw
 zNVobg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqrc7g568-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 20:58:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so29210525ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785358719; x=1785963519;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SXSfyuVk7nhwcBFF7oOD5gqIy16PcYgsT0nnHNUvLMM=;
 b=H3z/yACTluJzJ+pXZUW1CB7/qmRnegigKSnS+FpqMfeUqaIFO7+DuGV+eqSxUI0F3Q
 i/+vMHHMjIR9nwnkVjzlzax+ph+SqjI7REQrByz1IIRbL4q7W4ClxUBm3ekruWJlxZ2x
 ZwL11Fp/33U6ccRTSEcSK7wpa4zhMSiUOdhVkbxXdfJI3sJI1gt8q9Cqy+aZYqbqS2Yh
 pglzwQvSkrj4s9N5IJ+HorRJ7QpmIxJOqZIXsjBbB78Ac/3tLG927CvBDovdda6aqGr1
 v7QmWVdev7I8jCECtey9aVOIoW9UJsIyINhgThr4EA/C97BH3zko6L0VkRMUotJSuR9A
 ywvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785358719; x=1785963519;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXSfyuVk7nhwcBFF7oOD5gqIy16PcYgsT0nnHNUvLMM=;
 b=HT6vKyqrpcXduWhduodB5hv4flXXk5lCye+RMYlwD1tH0a14+dbOeCJJyYF70LItCH
 GS790oulcUi0d0dmRRcjfoO9qoKTDGqeJ8e+fQQO7rzW+FurMG0qs4LjaJWev4wki5s2
 fK2yUHdBX2b1nsFvh2jDx9HKf6xnisKcu7Wxn+vo7XiXNQwI1HtFywDzy7VGPGeYNYeu
 Y5ubUR3iqfrIq4DmdcHjMsU1CMhf7Y+9K7xpO+R1cpJO13o453Ryzva8qhvHDmxqLjSq
 6A9dnAsNvmVD/yCBkM1Bf8Zp3ih36sVpfCKOA0WtiBmc/4H3ydqBwE/xKiUd7VE4rnu7
 +wnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RouTbn+K5EsF8nvs8Y6buBtLcpfX33sYPXX+bSBG7b7iWvwxo7nmKU5p4+3pu0/dFTzIveAu8Oi0ek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGNzlBg/LQLFSDAO8Uu/9qxi4RXAOQ8R2Uzr+a3XGbSxuhbxDG
 s8Wqq3lUC5d4RNjOhv2eO8VqIMo61gEVR5nCyNZpJh/p2Lh/0KVOM+/KFIz9V4VF4guik6BwZXx
 2agNjoJlZVNiH7nOXtRoyKcYzU890a194nwFvD/bXggO4b9KNkfW4fuQzUk9Ry4enV3R4hTk=
X-Gm-Gg: AR+sD12f5G12TXrNOYoUoXygAXTwnk6QP8jdHfF0jUuhqQC/M6ops9OOVg4HscaA/M+
 jnXv4I/MAgwGCLDA999br0ddjNT8bXnc70XWFMgZlwnjSEWD6Gi6MV9gfJy4MKNQLg30N65A0eP
 Oh75bexKbhhcZ1w9Y0EijcA7fpJg51m8L3hn/RSwbbTgZ/JplfMG1qNTRDnsvdKzc3SHHW5IyJD
 UAFYdO8pR/NkGoESo73kZizVu3IK2UuMUkkZ4jWzUkv/amguYnxlKZBApwCaWkSJuoF5lPVHsq7
 Helb4pG32CUt9Cc9Ho9xkrFfbMTewepvhNF08pdHeRnCF9ChtI4ZcTx698rdaNyfJ0G0aL9u7pf
 Cx0cGyeeMfwdAkKBrbwaSSZl7LRHyAbVoYFlBS96e6uPRFPkV3UuktA==
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c8ba5b7f3fmr8831057637.46.1785358718810; 
 Wed, 29 Jul 2026 13:58:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c8ba5b7f3fmr8831033637.46.1785358718423; 
 Wed, 29 Jul 2026 13:58:38 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72643a12sm19719815c88.5.2026.07.29.13.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:58:38 -0700 (PDT)
Message-ID: <20a19c5e-6f1b-4549-8a72-a8a99126f73e@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:58:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: use sizeof(*trans_hdr) for transaction length
 check
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: carl.vanderlip@oss.qualcomm.com, ogabbay@kernel.org,
 dan.carpenter@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260617212520.59801-1-meatuni001@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260617212520.59801-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: niSmvkGFi-GbMqNU6WFInu1Ul9zmcmoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1OCBTYWx0ZWRfX9tPAls//qFxy
 FnOp5jssv0YH12CrEcyH2STLi9XJ1z+dUBEDQDbLD6LKEBbBw/VmIjxecoGLpK9JfvXhMK7a6xV
 qCveSgON1yI2XN4YAFbRPGf1/ymOO9GTh2trNZXrpgzOdKtgAx+MxG/0FG4UcIEHvaMEkxMnYYC
 AxZHdlqmDt3LpJPSlYneBQpIf+5aB6uIEmr1ld/HcDKXP1asSjGJKwdRiBixbsc5Ddupbk7fPJA
 CgARHHCNTE0kVlIWExuCjoHC85f6xtBqZxNPaNe8NPSm72Qs4JEksTB+lbLhbu64vTt6/4szq9k
 Ta3RbJrzM4i4B0SgVF3c/c1A+7+8EoNT8W4i0YmWkbQcjlEc+6XR7fDRlPYbFAaDiHb4bIsxVCG
 A+G3tOPMVxWwgRuIF4jkYqVWO8Jmte7WRBow3TgzSWIKNQLKWmJ9dhAist+sz21xxeTrA7bNO/7
 oOD5HbnlySINvb61jZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1OCBTYWx0ZWRfX9MCYoL/9KQDq
 cqj/x4+NHkwDuvgY3FsCa6ge/sqQ9LjWZer3bnMNWvZrBKBwL48yURTYFftLFr/a+AiEr96B+y7
 EIf+II2SS7OcQtv31Ms16Zbfhgo2Y4E=
X-Proofpoint-GUID: niSmvkGFi-GbMqNU6WFInu1Ul9zmcmoS
X-Authority-Analysis: v=2.4 cv=XJcAjwhE c=1 sm=1 tr=0 ts=6a6a697f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=GD8_rapH8p4utXL01xcA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290158
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

On 6/17/2026 3:25 PM, Muhammad Bilal wrote:
> In encode_message() the per-transaction lower-bound check compares
> trans_hdr->len against sizeof(trans_hdr), i.e. the size of the pointer,
> instead of sizeof(*trans_hdr), the size of struct qaic_manage_trans_hdr.
> 
> Every other length check in this file (encode_message() at the loop
> guard, decode_message(), etc.) correctly uses sizeof(*trans_hdr), so
> this is an inconsistency. On 64-bit builds the pointer and the struct
> are both 8 bytes, so the check is correct by coincidence and there is
> no behavioural change. On 32-bit builds the pointer is 4 bytes, which
> weakens the minimum-length check below the 8-byte header size.
> 
> Use sizeof(*trans_hdr) so the check validates against the actual
> transaction header size on all builds.
> 
> Fixes: ea33cb6fc278 ("accel/qaic: tighten bounds checking in encode_message()")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Applied to drm-misc-fixes

-Jeff
