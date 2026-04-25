Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA38FF8865
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 22:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C343810E1C8;
	Sat, 25 Apr 2026 22:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NB4kJVvw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LYngq/m9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819F10E044
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:44:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PGNKMU2047979
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=69opmhO/JckTSfgkLtNwnsdf
 o8m6zXst9te6ZZrstnw=; b=NB4kJVvwXpmcmlUL1b8lE/MGB+zFFytqutrgvIpS
 2qhz1QIrEzPZSSWzgZCr2+kGaaMjrxQBsNdcb9kSwSN7+Asr3q5iA1paVk/gdsmM
 6PreTbzcrVS/wwexEA7mLfPVzmhVIZyaJHDpBXlJdqk9HHLYaNjM9Pe1ZkfiQQ+z
 Dqou8nMjmBLxqncfQ2BNb0hU9tQYzUvXGf8xw/FEw/n9Bprnwp13lWIE08Jtw8kU
 FY0BiLXUnbVrPXgVk5MhNl8mil7LOM7mHPT3oFievcrMQYJRoUv/yNHvB2J03UTY
 HP8i9CdNMoSJ2qD8tZ1HdI9hfqQK6NtilcmnS/VJ9g5Rzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnq5sspc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 22:44:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d6bf346adso111356051cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777157067; x=1777761867;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=69opmhO/JckTSfgkLtNwnsdfo8m6zXst9te6ZZrstnw=;
 b=LYngq/m9hNPVTVdIIHprmXgDmczr+52icvURRVtIVZbtHV9KHl9eDTd1cB2YCrFBvh
 UjIJ0ZULc7ooiFopYGyr4l4b4y3yawls+awYlnnP7ljrmBvpYdSgQs6xkbp0VVqZgoX4
 wlac9e8b42k4NGAIc5ppJI4akRdKT3YZ/1VMOYontr7smCBmC2uVAyJeREeHLH1A9gRJ
 bcbplw1tAAxkjjbNP4ue2sBwtUMVGWnkQtJkgNUZt9iCi21Mj/kPebHMV+8FMzYiE8PO
 BVcr7s0iBl31X47mTF7TmsYouoVANJxu7ylPH0hE0FdTdptA6c/QXlZLJOIAdwH3nZFt
 9PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777157067; x=1777761867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69opmhO/JckTSfgkLtNwnsdfo8m6zXst9te6ZZrstnw=;
 b=dACzOmO3T3ScGBpKNgNJae0g7PNzoc58C6WRmxKK+pTOUAD8sUhpvKH/8m1kLOfRMD
 lFK5cwLOr/xb+0sAWFEr/kHkn2Vobt7u68Eou1I2l917q98xB2CFi+uhVh405WKMB9fj
 ogb/eS/+vrftBx4CcBtU4bo0mMvO57O3oc44g4NfMqJvm+RCA9+cSw7f5J2fsLxUQNAE
 VtC+yImOeEjQjUC60Nz07QDMmHVneFPCTVPZe32Bj2BQ4GVuaNNhDwViBLG/o/R0s36i
 iN8PEKeOG/06MitVPzfRfchFt3TZ8SUQcgJPvd9Rik/M/RPq2ShvN28dQ/rKj0IzQeW1
 0V2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8czxSmDosH3ZfxnUvGhMcTi3o9cHYqyTJvYv7B38zkwf3of9yCuv5BDMw3uTp4hbc8z367teklIUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx+1uqXUcayWYKLYg77q6mH4+vKt36JKamNfWnlEoN0au8YQBW
 61zqIIuk7vpP4ij+mSMZ6iDmbb/kzavPp/M9qCoXhX4OiMBi+jO6Rg2Tl4lCnnY52nqmphZ6FnG
 PYo6bxyF2j6o0DWGTE5kn8oxXUJO47c2c46M/mjgUpgszVcVIt3+eMF5QcNzuKcS1jdDVDbI=
X-Gm-Gg: AeBDiesr0s/DHp9Q6zijNZ9G4XLS6hfXGVlHHlubNio/E7ddwl32hsfF1NZajcMcH7V
 xhyJXy2uLHvZpGFnjEGA4ZqsUXWrBFujdZvwJ7zw+TVaHnErKOjQMBD+SR0zXR/HnPEM1FwJWVl
 31e5LIjyrqUKR/Q+McNYluEygtBI9NpdqAroDMRvpoHLojQEp76V2M0+QFo+SdpLXq3wq/4FpuO
 HUmJ0bpqD1V8Hks5jEFAeZ0o9firH9f8wg1e9vJvrzxHEwUXJSxoDb7BIpZHs5T7t5wo85RlHfr
 zUv/ouNB+hJGgImiwm+gCzAvK6SpZGZOgqOwRWmt3fNfS4/j6dvvGufvOmE9z+bCCLlYiFPY8xO
 HfR7lKx9OfbITmp16P9daVACfpjtW67nIbDVhM0CIADNmI6BC4iHnIGELj/Vy9YF93FqFr5iY/B
 /+Ctp1IfRgGvGbyVywRkVLX4byh222WaWZUn51BEw7aCj/Zw==
X-Received: by 2002:a05:622a:4a0c:b0:50f:783d:8cb1 with SMTP id
 d75a77b69052e-50f783d8fe6mr368477781cf.58.1777157067257; 
 Sat, 25 Apr 2026 15:44:27 -0700 (PDT)
X-Received: by 2002:a05:622a:4a0c:b0:50f:783d:8cb1 with SMTP id
 d75a77b69052e-50f783d8fe6mr368477591cf.58.1777157066814; 
 Sat, 25 Apr 2026 15:44:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc361sm6992581e87.32.2026.04.25.15.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 15:44:24 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:44:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL
 init in bonded mode"
Message-ID: <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QNxYgALL c=1 sm=1 tr=0 ts=69ed43cc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=gR0NIcCwXHEp-eBqhiAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JGhUyTiJQgVNsaf0d46VE2uM3kH2XWu3
X-Proofpoint-ORIG-GUID: JGhUyTiJQgVNsaf0d46VE2uM3kH2XWu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDI0MSBTYWx0ZWRfX4+QITrMe+eYk
 PfcrWGKHWBS8FUfA1mt8T/sL6AmqpCIdgfN+MbxPQZnoxTYtoQsg/83IRtCMo3/JOb7wPMWARnm
 DSuV7E6YjbvKHO/uPNVS2pEnhXsZPNWvdcQXNtf7eOQw2IjF9wRIQw2aBA1TA3CShQXKx2nOQOY
 SVuglDDW/4C7Cz8hwBkF0E6bM2YeEnHFnmwn0MpSeynIwvBN0THRuOfOdfKbCWcsqE0cDyFrb8A
 OW+CG3NU9O+Xg+c3KptzXGWeZvqmW76Rgh7bks4G/BwbRGeOdchneZbdpyLKagjLDR5pP+tsydQ
 chnFFhE4PwmVNs5xNrYAAFw3gQxH2512xM30N3g61cRw96fQwXI+Wvk6kv4ii9Zx1lT7LvCP9J0
 xUszbWIl8rOEPsSEAX7zO8rMaEsnNy8EH5YJ37/jSnhAE3Gs8TGJjtnHFR6/UOT1SE1J+WsiJMQ
 sFDH+/0Z6QsUOtU7zkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250241
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

On Sun, Apr 26, 2026 at 03:38:49AM +0530, Mohit Dsor wrote:
> Hi Neil, all,
> 
> We are seeing a regression after:
> 
> drm/msm: dsi: fix PLL init in bonded mode
> https://lore.kernel.org/r/20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org
> 
> Issue:
> - Resolutions are broken after this change. Like if we try to run 720p60 it will be 720p30.
>   Even though the byte_clk is set correctly, the bridge is receiving half the byte clock.
>   Some divider is getting set which is causing the byte_clk to get half, ultimately fps to
>   get half. Some other resolutions may or may not be broken

Please provide necessary excerpts from /sys/kernel/debug/clk/clk_summary
for the working and for the broken cases. Also if there is a difference
in DSI PHY registers, please capture those (see
/sys/kernel/debug/dri/*/kms, provide necessary DSI PHY regs).

> Reproduction:
> - Used QNX RB3Gen2 Core kit with lilliput display and lt9611uxc dsi to hdmi bridge.

What is lilliput? What is QNX RB3 Gen2? Is it the normal Thundercomm's
RB3 Gen2 or some other board sold with the same name?

> - Run 720p60 usecase on hdmi with dsi to hdmi bridge.
> 
> Expected behavior:
> - Display should support the expected resolutions correctly.
> 
> Actual behavior:
> - No display on lilliput display.
> 
> Additional details:
> - Reverting this change locally avoids the issue.
> 
> Could you please take a look?
> 
> Thanks,
> Mohit

-- 
With best wishes
Dmitry
