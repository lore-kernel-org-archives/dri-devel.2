Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3CFCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72E110E95F;
	Tue, 13 Oct 2026 18:44:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8C210E927
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:44:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3T8U442764
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=; b=HxJc2XMJwqPJDmQu
 OZRAgDrOy+Gs9DZy4hksAW9MZDS9tQo22XwOT3Qr9mc3uO64t07R+IvzFHzyNo/X
 JejiIwF70nvPy+UCYOiIO6e/+Se8cSxNet2oY4z6QwWSYAIDVyIn8GbiQqRR0OMh
 IRuGVxemsg/iVlDQprHHXdDAiYgvz97zu5RXQZLM+HV/9AeNXI4RIor/GAFUn0J5
 EtB+c9YAuldzJ+iR3ieek+tiliykDYoz+jhrXEMJIlEq6igpUewlycfOeh/STaTq
 Mkg/TyqjXkoApj+QlxfyWpHDGG53KGhilHMQdklMqXzXAbph5DsZSgziSh3fX+Nf
 XDPNOg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71hmm0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:44:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1665200f4c2so4600881c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791917047; x=1792521847;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=;
 b=SHGyo/y6R5tHLsGlDG3pO3W8C4oB7TwRs9mKGhWTxk11nkNh82Ukn2GAgY3POoDDQf
 zS1vKPhyxjXQZ5Vv+lTf28Bl+XpXr/umvBEAZQ2x/pcNOVo0HLTYqUPY+69vWMaT5d+p
 ia3xNdV1ow1pWFLlZZxHnr8VGIe1SgedN3/dRbSj1BUUuUPASXC+pb2oXBVqSFa0ixKP
 Uyf9lfU+703NX+PhBHt9KVOYs+RV4TKtvGletaIc3y5lPjxwyadJAifR4qqpc9ZdJbyy
 Y2Kbw/VHwkdMJp5qtnLgm8x+jHZ1GuNhXCM5f/1Y7ILh0zgO4HK40od+zfCpoTAyCdgx
 6azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917047; x=1792521847;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TAJ3OilOPOsiftZNwjsnJ+TIz9YE9dQrowEOurHsbB8=;
 b=h67aE02ZXTTK51YaN/DZ0HYzqJqamQ/cY5V/ADljy18sDGqdCgbTN7ZKs0tyiB/9Ft
 6gjNetJt109Xz++vNCxAFPrmTMPyYl9/N96ubHP8RbVbrQN7y/RjdKlI6xgPC6W2kuC/
 LGSIqLHRdITry2edzjcQpCxMbZ0j2XLSTr4cQyxHvWSD1iF4as5ZhmTlUZ2983oKPj29
 2T9BPOHSt9UlEdsOqQv7YLqIQpgfNy2STCICztzVvh40GtW4x1NPXHNYYBXugpMK8bXo
 XLclESbnYyURfSkxmZALXRrNVgRocTnKTGnHXal1DyOZV38khvtr/BGFm+5iDWnTFMlT
 2Jrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQIylqyZyGu3pmj1X0kfyexhvi0hFsgD0/IZKwqLh+RYuK3R7TZrCABEZc6GCe0rX57QcVINX/kOE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqnUKGv0SGDskbGE6/Q9GsO1O/15qwqLyx1g7Hq3Oxr+nxQ1Ns
 6QJ4uYWjivEfr/Wrlddicehng6kQhT+Z/AN4jvzNrVlym/fRmV9TC9zjp1bwp3Kx/2JAaTGtdWk
 0/k05ejooX9fa2KwcKTXFdh41gEGcp7zt0TzFjrkRlcI2lv1XWGCBUMioBoSbep5KxTFC9kk=
X-Gm-Gg: AYBFou1Wb3blHwFEWQnvBoX05yyWOTu/048+RjGy2eqE99SyWimtzYyXmWHJx/FXqof
 xmDdA9EPsfY8mSwF6X5makb8+sgLmg+t4BM7MrfhQhMU+vjivRY7G3GWSB3UxXIB4mHO5Ch0b5T
 zLzEbuIKuLHHrX9CBHV+sO7uXVVQ/IIfYvcpItuOmZE1TFcbR+mGoNX6NOBIIGPxCoO7dWijLzO
 0n5HwVMfvFpDnZd9qtI0tN70hS9SjeYzf4pwMVF7X2mdwBznk21lNuaoxD2G+MVuapRFIeYDav+
 zMEXv0VYyX0P73azjCYakJRMyKoSg6piBjE+/cNhOtGK0Imm8eFh5FJXeDz9U3P+W7IrHOE4UrT
 Rl8pYfxmJgKv8s/JTzaHCcV7vLO3uVIRD/yJYvHxqtt7dMd3nIA==
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id
 a92af1059eb24-16a5cac06f7mr19510304c88.25.1791917047299; 
 Tue, 13 Oct 2026 11:44:07 -0700 (PDT)
X-Received: by 2002:a05:701b:4588:20b0:156:3684:96d4 with SMTP id
 a92af1059eb24-16a5cac06f7mr19510270c88.25.1791917046694; 
 Tue, 13 Oct 2026 11:44:06 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16997c21ff3sm40087467c88.2.2026.10.13.11.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 11:44:06 -0700 (PDT)
Message-ID: <1fc34b15-f762-4ae0-ab3b-735d750b7581@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:44:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Cancel Sahara read data work on removal
To: Myeonghun Pak <mhun512@gmail.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260917192512.56205-1-mhun512@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260917192512.56205-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace7bf8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M-qdFEnyM_m4QQ1dQMsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: PsHVn22ulXiviVhjcHZuThIb0cfEf1ht
X-Proofpoint-ORIG-GUID: PsHVn22ulXiviVhjcHZuThIb0cfEf1ht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX+YZiecYQtVd9
 KCL8aY55a49mL/+qwfNzVO8kjV81uxXqu02vEW0EMzJuZGtryVBLrCaYgzWsNk+VAlbJlx3fMKC
 hRMnnyiupN/HBxvpBC/PJdshhzutDiZjPxbrS45MeF7lYW/i+33ZHykwdWtoB4aY2OVvG3kOsW/
 v5rLzI410yW6Rl2+fYtfG2oAjcS2khBqWuLzJq7m+kj2M5BNgMuRDJpcwClvrOA8BdipSWfmS3V
 RMIc54uq0PxkhsoZbf7ilGEdjwa+YhitmWMHLUel4Is78RFHDsPT7tXFqMWtdPNJ9hsRV+XViT8
 QOnqm0AhTvAG+9Ykk+44jjV/JYvtSdH0cOHMSwtvYMRR+IhJy0/aN9lVSFN7syVVPgV6Y9h+4pQ
 k/I6R0VESAuUyy0i8WAGLdcfIXp0gWf66gwR6aDIdk8q9p1SM+Dpb/ycw3Zf+uAd3ufILCu22w6
 5frNR2yAkZu7d2MW6bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX5v4nu0BfiJFB
 nsSp9LnpR391GrewWjvd0JanmV260L3E/SLL9u9CBBtPTPR4uLrR78rQ/bWyx1wmikmvc4PmZJB
 Zsgimr+iyKcdGoef8c1jH4HBVx7nRCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130074
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

On 9/17/2026 1:25 PM, Myeonghun Pak wrote:
> Sahara removal cancels fw_work and dump_work, but leaves read_data_work
> pending or running. The latter accesses the firmware and the device-managed
> context and transfer buffer, which are released during removal.
> 
> Cancel read_data_work after fw_work, which can schedule it, and before
> releasing the firmware. The MHI core suspends and resets the channels
> before invoking the driver's remove callback.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code. The same omission was also reported by the
> Sashiko bot while reviewing the Sahara relocation series.
> 
> Fixes: 7fb19ea1ec6a ("accel/qaic: Support the new READ_DATA implementation")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260701105055.8D4371F00A3A@smtp.kernel.org/
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Pushed to drm-misc-next

-Jeff
