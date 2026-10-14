Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B0CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7154E10E55A;
	Wed, 14 Oct 2026 20:58:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038AB10EB36
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:57:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0Lp905401
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Tdom7tnqrfqhiAr3bCDpoJLd
 konZqaXCM3eCfjDGwls=; b=GkHw6Xh8yvBfUCJGvTj1kZUo/GEDtrYx/IkPailO
 U9A00x8a4bHWd7+s8NvKGyJnHvCh0ac+SB+ek/pSkxbn4dZrHOaDJh8YmurDNstR
 1J2AwTGh72QKS35T8YLeYMhcjMq8yxU5PTTYjHFc4FnmVP9i1kUZx83Iq8Tp0iUM
 0bS87QKAB74ukuHfRYfo+nd2H5T58rYMK4JGY6y3m6UxLlMH5hWEuI5NBliTGgDb
 5r/qQKwrWx6L/LM0u2EWkOgM3dSXtWGCrkRdcTvZmzokL6/t5xaR/fhfTLaajKWB
 gp32Pe7sOVcq/O+tg9wj3Umvr661dEUIK4q7vfkFjB8Aqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p3hhx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:57:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso181240085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011473; x=1792616273;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tdom7tnqrfqhiAr3bCDpoJLdkonZqaXCM3eCfjDGwls=;
 b=gpO7QxESvyWoqYUwl9PrbczYSTFrazO8ZveN44AjlS62dYtX9ioLQhuWxI3ZqiSjsB
 TmUZPTkU1+qsIA0y7x/Zvre6l8i1mam2pO4GzigTLTHz31p83kVZzX/AX7HeYWa0z5xW
 DEpqP3ZEOOLd+hgHjZbStMsr6NQxs1YDopYYFbrzDl309LmQ3Cr72TGBnqZdMhKJSM9h
 QNdziJicOhhZcg6rKv2tL8BMcFRMuinGjN+noWACOzfaYZyYt7HyPmk1zKAc8W0vfCNU
 PNangW3od2vs9j8E8/Fa//cfY4edhOTtKpyy2j2nAJri6+XpAm4cwyEfl/5z9BNSTC7H
 SXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011473; x=1792616273;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tdom7tnqrfqhiAr3bCDpoJLdkonZqaXCM3eCfjDGwls=;
 b=AXhExG7zDWQJPITRrMzTziwEQAe28fd6tc7XegpZFNnAqTNulqSZwkwowwnCL+gL0D
 BhH1PN+AtZU14JNMfAtvZ27hsu7c+bd2pEWKsAJoPY2Fv29DtfKKHxrw1/dbdYNUviKI
 S1k6jOmlB8HSTyQaj1yNOj9eRmdQdOfvvsXGF9Ns46XUlAD1crRvonoIFd2ntIi5jd5U
 UunACQF971MVrz96j4IwTCDjka60f6cz1eORv6CRXaiZMmHaWmNmua9LfZdgUIgxRPn0
 Uyx47cwNIwByTaLRFiQPPWqid4YcmkGrVze3qBlZ/l2AhJ8BkEiaVicQxMyVwuLAEO7M
 foQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2bOfxF9WnkXgjHuJPMfHFJIb3cO4I9LW+hXl5O9hiNB+HupJlV3XeY0EC8jlbiQJI9jrjNjrGdF4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxkfMJt8dAkgnWAwndzUt4zqvu9rP3AH7JWa87HVxvHygoahkE
 cS+VtI10jX0oC+hYB8t8JpR1wZUUoF70evq74uagzDiy/oQygzNtP0BTkgTj7IR2gzFkfzW2GLD
 QJ6tHmCzta8zewA6BL7sj0XWZPdCEXjbh3O/763YbFb5zPZ5bhntOGqYt4vCb9GCzS2Venbc=
X-Gm-Gg: AYBFou2SCTfEQP2WcShVyMxsU5BjtTarkddJTDx7hcneRxhvF6HfEYzPhKQh2eIF8kE
 ZK5rzX0TXC8d/I2ftzfeWh/e5OMCnDG4t0u8LGV/eaudlYUPyY5bn9Uct6JWRvi9nT8eIQsgDpu
 H7r8Mt+IouSl2esa2JAxndYltgAiT5wfey6uGitckCV/UMsJawyh1pPCML1tLed3i9I+T/INnE+
 XvmcgKt50VGRS1K58bNmzha0tEE+aYWpa05WN5t3YnIAUeI4UH0kjyVRE9vjkGEV2648S/lDxGQ
 4Z1eD05FNlIa/oSx2AsYSSSJ4xGe2tEX8DWLU+I06rTEXTdsWUVoAj+daix9HK8u8S9giZnakWg
 AnjAo4Da3tZqU/ftfHRZG3BkafvOxo5/z+lyw6WZnJyx0i8R8SkOV6lPtPhPiBjhXFy7ABOYRvA
 SQOx/pkKsj/wWm
X-Received: by 2002:a05:620a:3194:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93ebd2963bcmr2795853085a.60.1792011472913; 
 Wed, 14 Oct 2026 13:57:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3194:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93ebd2963bcmr2795849885a.60.1792011472382; 
 Wed, 14 Oct 2026 13:57:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdefdc4asm1613741fa.30.2026.10.14.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 13:57:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 23:57:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
Message-ID: <rqsztjjpis5ddd3adpwds56svbbeugoh2zhzlat5jilozkzncx@jrwnidovsh3j>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
 <20261014-sdm845-hdk-v2-4-6d0b4b42f267@oss.qualcomm.com>
 <sashiko-outbox-171533@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171533@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MyBTYWx0ZWRfX8GOwRhvB7/6H
 48uVV2mYjIPFnoW6dVbQd/mMdSoojNASZe1mWtjXyAbPWY8VqpQmkzOZ9oARNBfGLITWGxWsP/p
 pgyHhuzSua7WBUChf0GL2DN6cQcw4m8=
X-Proofpoint-ORIG-GUID: rkVXM6v5G11TaTLn_jxjbM22eygEG7Qj
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfecd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=s4Caojyv45IKULvEKnIA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MyBTYWx0ZWRfX/RRhiMftAzqv
 fEe30HD1EPxIM6tApL0GhCXPFCKVTUhVP8nXYulf+KY4VG885OCuQ0ceTzgdqOlxcox97VTODJI
 UK3fWvoGqGLlvekgvTBa8mlpd6R7C6hWdz3/vwf7+Z7/l4PV1gy9GviMrpyP/xyCJKYwAB5mf+A
 aLtRAIJTZmoKufbBuH6NaR76jq8dklfB+az0iidzEMIuYdR1nnmtvxSk0viPvghjzE0FtdzguX7
 37ZRmkoRGLfwOPFUW8gU+l7vUBb0Ymk2YPZy0idQ6Mt/EdH52se+D70jDVsK6Zg0yxvtLtW8fSa
 WbLWjt4U5zUAJUGyFrAyMd8V3JUL8vV++yFqJRZ+6enhJaEbuW5bjeKoBFmm5pJClXInR9sw32o
 Yk1KJEbGL0W+8PSq8a21TTWuOznCJ76ezdz4Le42bWIahYG4Ypor443tjEmFCi93UgnfOnWXeul
 tZIXg5K7BnK/TctHaBg==
X-Proofpoint-GUID: rkVXM6v5G11TaTLn_jxjbM22eygEG7Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140083
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

On Wed, Oct 14, 2026 at 04:31:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] dts: usb_1_qmpphy swaps vdda-phy and vdda-pll voltage supplies
> - [Medium] dts: home_pin_a pinctrl incorrectly configures gpio6 instead of gpio5
> - [Medium] dts: impossible 1.8V vin-supply for 3.3V fixed regulator vreg_sys_bob_3p3
> --
> 
> commit 48f1c407e24f3899e533d5dddbd59a77b4901a02
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> arm64: dts: qcom: add device tree for SDM845-HDK
> 
> This patch adds the device tree for the SDM845-HDK board, a development
> platform utilizing the modem-less SDA845 SoC. It introduces initial support
> for features like HDMI display, uSD, UFS, USB, and various onboard peripherals.
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk.dts b/arch/arm64/boot/dts/qcom/sdm845-hdk.dts
> > new file mode 100644
> > index 0000000000000..4dd426912d20f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-hdk.dts
> 
> [ ... ]
> 
> > +	vreg_sys_bob_3p3: regulator-sys-bob {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "sys_bob";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +
> > +		vin-supply = <&vreg_s4a_1p8>;
> > +	};
> 
> [Severity: Medium]
> Is vreg_s4a_1p8 the correct vin-supply for this regulator?
> 
> vreg_s4a_1p8 provides 1.8V, but vreg_sys_bob_3p3 is defined as a 3.3V fixed
> regulator. A fixed regulator cannot step up a 1.8V input to 3.3V.
> 
> Could this create an incorrect power dependency tree, potentially causing the
> 1.8V supply to be kept awake unnecessarily or turned off while the 3.3V rail
> is still needed?

This is the least awkward description. This regulator is powered by
vph_pwr and enabled by S4A. Using S4A as vin-supply is the most logical
way to express it.


-- 
With best wishes
Dmitry
