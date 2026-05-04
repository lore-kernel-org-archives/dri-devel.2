Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E55FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 09:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C06A10E3D0;
	Mon,  4 May 2026 09:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jT8UcqmQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2mCB3s4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69E510E3E5
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 09:22:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fSR3459464
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 09:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=; b=jT8UcqmQQ7n8kYzv
 d916VXBnBVQAm78wuEtAHyF33nuIfU7O9muUTVQLHdQqRCsxCnXUQgbmZ0fXA0qg
 VmH+gx1lXTg64WQaDkXccTDHvTbf9NCeimH7F3QvzoHpBClvIZjBqcRFZDiaKgiv
 5qcakwNqNRUSy/wv2UxnUomasVoiBjozKqMsvBe0/7eJysYubnJaFJGtT+FNI9ux
 OgE/dxTSRubj28Ew83LknbElbkH3kqwyMivwUvQUpW/TCMdouKIirLws0rS6Mw3M
 Qt8JuiFnIajoHlvcRdHSE5t+L63sURsDNn0q2ML7g9KvopCF3sLVwS/98cB8bEpv
 u27RAA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejn19e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 09:22:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82fa5ecd760so1762547b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777886560; x=1778491360;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
 b=W2mCB3s4Q0xkIkx0vnGyb9u3EqsWUwoi34gDOJ/FjMZDeQPYjSoK7G9kHk64OkxPqH
 FYppVyGa/vBSC9NY3LW5eqkPmlZ09meEKGxNnS9PV6HlYqE++j3dGNR9eFvCmRDmuGsd
 oXrU/X0/ga706/bbBcD+VHik+RWn1NnBNCDXIE/q3O2JYUkRfElYEeMRbJj6JuxLTovK
 gnTzpCCcxwhzCdP7cZkNS/xyKv7aR7QSVQjxw5I1E2/j/dXB6XHedyg8550LIpP92Utb
 RL8pThBE34YNvprlLSwRgraQrMe/Pi8Dn7l4l6LGLVo6sOsGPnakv3YqQ6ZZV01ShzZd
 CjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777886560; x=1778491360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
 b=mruVWP66UfuGgHsHlkD5vrrbYpO65z01BXuZbUd/T4t1CSsm43Ip69E+pTx0UKqGIp
 Gx4gk8eC+7hawi4yW7htr1JT9ek9iLvSrZCv6idpnZ5Flzh91QP3Hkz5hp3o2751QlCl
 t13sESzx5tZSNvYg8kqwwe3CKY4LbvQopf4ISOygWgYzs92DQi8PoYQ/hsQk+IdFhdZ+
 4niNP6wXRsrFLvQlBtZljsf/QnfP1143Nbmg5C/90EGj+gsXh/aDWf7Sy4aiQf97KJ/u
 FwQy90KF4JG0x3vNIKmPVhpElXTS9FlCSnCDgJlZw4h7Qx4B2BOfZCosIQDzmfRllFBl
 Ug/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rBp5pJus9vK5dC9w2kUtCW6ViIuYACXtYgNQGYX2lGz74o3+zNKR966VQ6lqYTeVUqd/B8xo/gC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfZe8oLEThiOs6aAV6wFgrJxMCOxqluL9Zj+vouyNXTNY/0Pdy
 RqTqSVGy+3NpjWof7n0FIRKRp2f6Hi42GQhQvQ81Zch2zrA5KQzM1WuNHNGh4zR6j6dwa4rnn1T
 vBjb7opZfyEp5piImaurCsKJMXdIAJTdqdgO+/9El3zRElKFTFKCUNRk9snKLEGJcquopKv4=
X-Gm-Gg: AeBDiesSzydQReKCjSraQ7WqTOgBZWHQqD3hPYD8CP8KJ5Khuq9b0q/s94LkqbEjq+D
 fqJO+WhlBP/07yXtc9UaN+NFvIKaXLdTsyqGmvN2PwuhDEsMWOu6fdLdwq/gaQvmWwMlwikmJ/K
 MAZqiU7qSIuRnw4PczHqJC10ChgkTGcdrPRjMKPGOHBm2UL7h0mjveyzRAjDToIdtYFzo1VZ7vG
 Pyt4gs1dhFQU9SMU+n89sJMi8cnfg0prv44xwRsLooHt22CZ1aY0RDh3rM16taH/U1ZBd+Quubz
 0miKi0GKsCpFTeK35RzAn5KM4iWkujpzIGMrVhi5JXR1j7NaoShXKLT9cOFMbRubSgyT8eYnCIV
 t7u79lVP8rFBpK/M1ktTg4lYo2yGtKEbsYrIXv1F86mYArBIQzMFdRTp1lnN7vw==
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id
 d2e1a72fcca58-8352d1fef20mr8936699b3a.25.1777886559717; 
 Mon, 04 May 2026 02:22:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id
 d2e1a72fcca58-8352d1fef20mr8936668b3a.25.1777886559217; 
 Mon, 04 May 2026 02:22:39 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83775b1eadesm3030462b3a.56.2026.05.04.02.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 02:22:38 -0700 (PDT)
Message-ID: <ba8c170a-eae7-418a-aacf-92b394c401b0@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:52:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OSBTYWx0ZWRfXxdft3JQaX9th
 vgEfALcCFnpZrGoxYiTdT9EXgQv6MRQogcbyGkK6YoHIOqtedYmdVBUkBlWWVaLgybHBOBw643W
 TKpbkAOlcCk9RvoZdRiL2re7SUiXjj0zogVlW0J9B+EACwzoM8A+xa1T5B/vtaz4WcjmHueyHUJ
 315bP7Bq7ZzcPZSNSEYMPQDG7VsfRO147dyIO7grXVmu0JJIPxZbjNwOfh8sfosp4BdT79ZQOAn
 D870TwNjd1XQeBm5+qRjWag2xJOXc+udmT1gLiCJspM4Tl86Q0sqWUMSZ4Rdlrl0B4KFQ+5uDmL
 oTedvvB+xCKV1eNxlgY3I7LruVVwCRCcmRFZ1J8DcIaiUQ4H7K6ZBJKk0L2x3EyXctvlETP4pLD
 K7P4WA4hTeJRwLlhoX/MR3tsZ8abuiWOg8KYycz3ApRLE0ijemk5+rwwPRmuA5+HZHi8P/jmnau
 DNC2JqdG+FNJ45yD+iA==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f86560 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=58GAH2X6W2vqmnVK_tYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: QzRT_m7_XyrAYX0FoCTunJNc7-1UANVr
X-Proofpoint-GUID: QzRT_m7_XyrAYX0FoCTunJNc7-1UANVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040099
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



On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal

