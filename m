Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C3606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W96HaUKE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aDkVcmje
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBBA10E432;
	Tue, 27 Oct 2026 18:19:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED6810E432
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:19:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHRZA2639301
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XsKGOF3Zo4sw+rWuIBG727C6
 syOZ0rhbz1KXJVsitTc=; b=W96HaUKEm0F27a5C26UjNGDOmV3odkiMiDYrNfzf
 TXCTb7oJsqrFdnfdOhoy6Ljer7CUhOYItnrgEGdArYuXE+219qhaU9pRRZmMSbVl
 1kpKpOzMMAYGyvUJrELyvcu+Uj1A2a11cvvkrxHwMiGxuubu/t/SA+2ltWC3XePD
 DI4dV2jtSh5g2xZVPC/MZKl1Av03Cpyd4UjDmpgUu/vVoqw3Pa3ErFPkt3kZ3AQI
 8w2TeDB31bX3L8JMcZHdzhHp8jjgxN7Rzew9MRKukwuAD2iVOcVCNOEdZGW8aCc4
 GF/YfDS4nsSbV5waQGuKAameYQiBEqR0o3JRE6eDcpcZFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5ts8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:18:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313b1501a0aso14018eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125138; x=1793729938;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XsKGOF3Zo4sw+rWuIBG727C6syOZ0rhbz1KXJVsitTc=;
 b=aDkVcmje+lfUfK/GNRamLK25/H+w6UT61/cyZttLBS6Ak55rg9DwxTPesgdbRW5PCG
 qlcPBtb/8BJadSI3Nu6uw1tPLiJefZ+WNseikEpowSn5aDu4dqGbVKOqotKfHyE96WnL
 JYh7hL33rZwG8i7SLsqf5V1PkzmeNZ9GqtvnLT+C1JH++zkhPc0PanXKpY+K4ysEwv7Y
 DcKfWxmevTZTz+2BtWw9WTM6tiyovzS/i8cqda0cCv9ly/ZlLaerkT6035UZgxbax9Wx
 WAzFuhzKryIwQas5M1ulidaqfXQWURx8SfxNjuPE7XXyvQZMlL9Xkcs7Gw34+ba+ORZ9
 Zotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125138; x=1793729938;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XsKGOF3Zo4sw+rWuIBG727C6syOZ0rhbz1KXJVsitTc=;
 b=0KsOekHGH1WOHCVEL4vAIpYRpySCT9MFczdU9JkgafOfAZeFeCgHGFfZtXVi4VhJr9
 nqcOM42W+F/rcFy9hdEnu0J1Q1LrxncChubMUwzsdPIWEokTopHvlVwlock9gbxbwp7L
 1Fq7I/iYKl/NBojbnKJesnNxkWkBmSnjFWzSiQ8K8OcljjhAl0ikBqv4tF62CJzMIQ7H
 Q7L5MEJBk52mg71eH+naXkj/VS+Rcrw1Kar5FkCJxI90WOi/eA8SnU4lLlHoYuB+XAVc
 +QwfyBQ5flKDSbO8hYJeMhdGIMNmUNw7rB6vB9uE5n1H8rosaA64j6GgWTwt334rDFOg
 hqSw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVOnofFdoGQ+W6Gx3VGEnTSmM8I2DZgdlpyS8Oxtt9vU28ULTs0urZLSsTWDYDSkyIh6IM5ilEjk8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzViK9rj/TMM9X3fBTWZ2lJ/MfkxpIRC2wW6XYKKLuPyXQNlFq
 dmwN/p2qAqYBB186FlNTVOM56mtJ7kSPROYXDHEjaPv2CJmmj1Ualtc15AS2N3WrQYxIPLOx93Q
 kcYlVthrrz3iMrsl9lVkgB4t3ke9e8BjdrqipghlRYIP0IT4mP3+jAtaBLf+ldRMAB/GezSI=
X-Gm-Gg: AYBFou09F1Y/oH0SdcWX7pPR6mlf1B35zTTvm+zUtn5IJ2n4fy6W6RUPFQh8FRzzLZg
 lYgigNAC2ALQr4btDbXan0A60fLrcDtVfg4cSO0sG4RxBAYFKPmCgM4SEwSf8FV1HIL/kMtYAeB
 E8TpxY96hCA4qtyYAvp5rUoBrI9VYKdNivDx6koSap3bBXkO5Q8vBX35/D3gQPslnc9ElmG+vLv
 6WRBn45n5z+ylpL1Y24rBV+xr6KzSMOwoxzH8YPxoIrApdewOyyMX8OJKfpA4+6KCZZC5vKVMij
 iegpkKLF4XG/R20RDfKijVue6xhcdr3+IwEEnNyz4m0eKmMu5U/2zSTl8qbq/jD7UaQ2YtimBDG
 7uPu9kJ9/+vLWqs06g5+PRYOwvY88ItV6wUshFspHl1d6bgHMUqxPepHXfXbUdyyHiXsMlL2QQb
 DobxloKEACY0yMfJB+ylH3xX2fPhTvkGKt9hNDxbV+dJUzoP2gyxLW
X-Received: by 2002:a05:693c:88d1:20b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a1ffffc09mr654509eec.2.1793125137806; 
 Tue, 27 Oct 2026 11:18:57 -0700 (PDT)
X-Received: by 2002:a05:693c:88d1:20b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a1ffffc09mr654425eec.2.1793125137119; 
 Tue, 27 Oct 2026 11:18:57 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369f4164886sm29475546eec.7.2026.10.27.11.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:18:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 23:48:49 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
Message-ID: <auDrCTMk3oCLa91X@hu-vishsain-blr.qualcomm.com>
References: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
 <20261027-fantastic-benevolent-boobook-272a9a@quoll>
 <auCDgewe04WKbamD@hu-vishsain-blr.qualcomm.com>
 <c58c89cd-94a5-4776-b186-44c4b1b3c3ab@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58c89cd-94a5-4776-b186-44c4b1b3c3ab@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX2ovYYH+WEy8S
 tspmXNk82z5azuLE8C79+audk8C74kTFIPgbU6tcfj+6ZqO2dz7G3uorgedFal/Mvpi9KQ5gguK
 7ciUhg6IL0Ty1hZD1Oue7M+gPEv1nMo=
X-Proofpoint-ORIG-GUID: UbulebdFli10-U88n1ZyaxuTDjJ-OiZ-
X-Proofpoint-GUID: UbulebdFli10-U88n1ZyaxuTDjJ-OiZ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX4hGPL+dok/rH
 SOFGbFdyCud1GPWdy7xvzwVDwsnF7pIyEGR06PwxCQC5LzK2romgXV3cLgIgutgzFTieX6/H34U
 h0KLMMrwotlG66jheHEonulEa0DkBV/i4swxbSAzfZ3GaBqaZdU/KD14XZfg6teAiv2ofwlmrGQ
 U2rePU2yFu72OEca6QA2i8yH98HLnIbuTNFeNELiJNq/k4C6PVeDd44qciTLEkRO9S/vjQ18ucQ
 kD9d2DC2lzR3ImOYBGyL+XfJIMmQrX1oguQoUWNKV75TlNxyuX7hX5hpsYPNvSj7paown61WM/v
 wdPpsanJs83LurIDJeeHqT8+AzOCSJhpCM/Y4zVNbjSH0qwShVMu8rIto25372uTQSZEiwXBdsb
 QfyEblNnNqbl22IXALFL0j55+xONMcCKSGQxuBqtKjbnCyvVCWZx+JRGYhnVGrpxrYSDyuMl/eN
 jXKtiriLXCaSmRch8Ug==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0eb13 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7rEk3nLCdkWhF05BNvEA:9 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:34:19PM +0100, Krzysztof Kozlowski wrote:
> On 27/10/2026 11:57, Vishnu Saini wrote:
> > On Tue, Oct 27, 2026 at 09:12:27AM +0100, Krzysztof Kozlowski wrote:
> >> On Sun, Oct 25, 2026 at 12:18:17PM +0530, Vishnu Saini wrote:
> >>> The DLC0697 panel is lit by a separate backlight device, which is
> >>> referenced from the panel node through the common 'backlight'
> >>> property.
> >>>
> >>> Declare 'backlight: true' so the property is explicitly allowed by the
> >>> schema.
> >>
> >> Why do you need to explicitly allow it? Since when?
> >>
> >> I see no benefit of this patch and commit msg does not explain me what
> >> that benefit would be.
> > It is required for below DLC panel, when enabling backlight using gpio-backlight driver,
> 
> How is it required? You did not really answer, so again:
> 
> Why do you need to explicitly allow it?
> 
> Answer starts "because ... " and you provide technical arguments, not
> wishes.
Because the DLC panel node references an external gpio-backlight device through the
backlight property, but the current DLC binding does not allow this property.
As a result, adding the backlight phandle to the panel node causes a dtbs_check validation error.

Adding backlight: true to the binding allows the common panel backlight property used by this DT. 
I will improve the commit message.

> 
> Best regards,
> Krzysztof
