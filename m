Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E516CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7EB10F6F8;
	Tue, 13 Oct 2026 10:30:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CA510F71B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:30:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D9OXlO173325
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HgwlI9xizsLKQYfDyomPoKaDb7JMV/G/kjGnCEp0kJ0=; b=EHjbjc67pHrSpEze
 NjVuBjs7uhpk8Y+M8YKX7K6sFfeF9iMdab+h1oHODkxD6wl6SygnauoZKPV19WGg
 9NwA1BO3N5cZPOk3Qcn1QIt11Am+iyQF7Got/DKVglgxuh/PzAEWOlMtgEUex57M
 HO5W8AbqKrDMJeN3co0woqsGZ5gWHAcfS+fbpV/116DXkNnxsHxAnrTuaMUrFii3
 /W9a1GcOjQMXVSwJVqkknO6K2LTalB0rzR4BBUHXyyJgefBpZOS5ZezwAWnnjwxy
 yv4inm6WJtuut+UIHzGZ2TSZHDCufuzKUythwV0if6J4GwSc/VNm1P3PVgC/OOHy
 sfMJ+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqsgkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:30:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e629c7b16so38885185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887444; x=1792492244;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HgwlI9xizsLKQYfDyomPoKaDb7JMV/G/kjGnCEp0kJ0=;
 b=Qv6oaXx0bMgt7X6I0ngDrNdkFlM0sGDYlr0M4rVlRqj0OLJc3YLKFJ0f6FbKFAgwDW
 uXdI5GMj733D1YuBAgookdVo0iETqQL45C4oU6uJ8zSJXBheBzpm9pUfTcD5pu4v1S+a
 TOPqlpvulcqsMobwDr/5S4JVIpMhl5LVkveV0zNZxa9vjcKN4oxrQX5rY9E4amA9JYcf
 2Kd0w2g+rs/foTosr9pNS9gs5dspMzerambMNEtVa1MdkPkLyKhbmgrJu3C0l16Eje5h
 r9cIAUBU5EBO8wGcbsel7S5hItNQZ+zmxRmGJNaHwQUM9RHx6j19c3kr4wN0Cr+pqKMl
 mesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887444; x=1792492244;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HgwlI9xizsLKQYfDyomPoKaDb7JMV/G/kjGnCEp0kJ0=;
 b=efnxs4yJqPjKIliy3vL8ELpAfniUQI0OnNd4vuDcAsoBYKu1jPRXVsdvGBetuD+cfh
 DpR64jA+SCzS6vQ1iP9PDthVi/5YtMZgoB0Sn6ror7DpNqa53ggZ3FQOwo23Xk67plgE
 II12ca1sC/nVCzGNFJ3MgeAZuUnWbVfednigQJYG2dLmWDfthArLEkPokHEmsORPbrK7
 ES0M6VjZMTvhH8QrNCzKW5WSrg35hYQD3xfnMAoURLNM2vfiXL5qAdRetNtJ0abVRLTc
 UZzjDmyY9Tnmuz1226ykwMcYQzucOg+dv9iK6tPhwVzCHOU7e/R6M5GSTwHtqVLS0P6p
 +PyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/AsQERv5ZvbSbn9ZG23r2Tl3ij8See8Kk10kDghHJkhSROAg8k+OhZZTxH2trQgF0rSgyMBnDu1M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBySvGllXS1nx26R2sIWmQOmBZhe91aljXcIV6V4pimWweyY8D
 EulNQkxNCR90/e31/px68xdnXXOqwYkEJ7dFZsNQ1DLHajSMb/UV7N7TOtTMfuXmPGcELd2U3Ep
 UDFM76My8orUx+9IbzZ+kaeyyK/wsdUIXsSvTKHeTHd4fouGdvT1JPaomEOXg08miDNrBzpg=
X-Gm-Gg: AYBFou3Qp7CtymG6jhNZjbIcPNwAXlHRbm5YRw4ucNNVznCZBfL0l/ILRHFM/Kdw4dI
 2qEFXHA0cVhukrtdAx7N0z1qyj4UDcl+PNE7lPCR2scn11Wl/9jOzS8nFdR4mpX9CySTyeSyshB
 R5c7q0kh2pgOBvRrYaKQkZoksvHkNw2RO7mQQA7q7JnE1mwfRE0tECDS9GfJtnhMBVg/tFiZLFc
 MZObdCeOZUiGqZX2sZhjqca4gcEKwt7ockJKQ+6LrBPuT4jYKPNkNygP4JCRgvXy7PaGiV5zhke
 qLiXE6vjcer1MKOqrz0d9jTMskt4EP0/wB0/pTPCVfM4iUC4tQuEgeKo+AK1RWdsAMXblVy8Gtj
 6e/kasOTDEvuSA81YUiy4fg==
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93ebd224118mr2251365585a.4.1791887443613; 
 Tue, 13 Oct 2026 03:30:43 -0700 (PDT)
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id
 af79cd13be357-93ebd224118mr2251358785a.4.1791887443027; 
 Tue, 13 Oct 2026 03:30:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a38050sm571524366b.24.2026.10.13.03.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:30:42 -0700 (PDT)
Message-ID: <762978b8-72ce-4836-85f4-2cd3ee4dc5cf@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th
 Edition
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-5-406fc042162a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261006-mahua-surface-laptop-v1-5-406fc042162a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OSNy1OAQryvaS08apuHhBlGxEIpf8eWV
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace0854 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1YZvB5OX3fR3yb4sgf8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX9izLCnP6XbZi
 MHTZ6X8faUO5aac9ndrgzbSQNxC094ovCKPl3YCaqPlzXv/rkk3CvdrSR5mYRWdlDAC8rwbZtgB
 AY+6iJXyjgCEKxCK8JGpeblm40kIW7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX0ckD5KMP0TKn
 TcWcgeiuN0ooW71qLVN9GSQc7mWEcWqAXJGqMICm6eor2Djqd1xzfOm1tnzVA3zXnDacoCp5ATQ
 ZcWOo3u//NOZgMBMvnFE9+oYFbppFbk+AGo0bd/EWunB712PD/bXWUpIK6iaWcbsNvWTE/Lo47k
 +c8e5/loIp+cPWVZyMznZICyKkxvzd6Xr5QGVN8Z60bfWUmnpq/5QRfV9Dvd2jSJVZA5GklEY7P
 huOzsd1z0KGSJvV4kdFKBhbBhVh+8B+gVrbGcP9GQLx9aMao/snKJ9fP6azjOlO/RElESmVMRg6
 VYVJCKYMdFem5hNrHbdixGPH7HCh2MlsJsb3YpduchpQTJMqgEhagxZo332Dvg9IGnm/LdKMHPd
 qUuk8u8Cg9HwbEpbQ3G7ucbSMg2yvw0/bRxGfCwz4d4xhQS9RMJpwCiaIxO+oMvIH6HdYnasolN
 aZd9eI13lbH00rnuR3Q==
X-Proofpoint-ORIG-GUID: OSNy1OAQryvaS08apuHhBlGxEIpf8eWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130041
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

On 10/6/26 11:50 AM, Gopikrishna Garmidi wrote:
> Add support for the Microsoft Surface Laptop 13.8" 8th Edition, which is
> built on the Mahua SoC. Most of the board follows the Qualcomm reference
> design. The keyboard, fan and platform profile sit behind the Surface
> Aggregator Module on uart22, same as on the Surface Laptop 7.

[...]

> +&mdss_dp3_out {
> +	data-lanes = <0 1 2 3>;
> +	/* HBR2 channel equalization fails, limit the link to HBR */
> +	link-frequencies = /bits/ 64 <1620000000 2700000000>;

Oops, that's no good - is there a chance this helps?

https://lore.kernel.org/linux-arm-msm/20260622-glymur-edp-phy-v1-2-814b45089ac9@oss.qualcomm.com/

[...]

> +&usb_0 {
> +	dr_mode = "host";

OTG should work just fine on both ports

Konrad
