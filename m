Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C191C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958A310F06C;
	Wed,  2 Sep 2026 08:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0JcRGmO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iw/27IC5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE2810E49E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:44:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6826VxWb853894
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 08:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=; b=h0JcRGmOW3yXBfJ3
 Jwg/N1/SmEx2X+CMj+1kJeGOLtnZ0m3Hzy7ubZpgM3LSK5QO8HNKhvVDxFOTFL+n
 cdKpYpumJFH8c12HE2yzjcbcsPSkXkpYoHbCx6wqEzWdGOad2n3eYt/By4kq8tsm
 qXgWaWidssOkHkYai8YrCFKBDW3Lnrmj8tiwsYd5vzPPMq+xZuMBQUsNZtiGvdpa
 mwVGB9FXu2w5aUUaxzAuIKl6Ssexe97sB8v3UzobuhuBSunsQ87miV0XuqtsCw7s
 uSXJ0Se2Xbu5nXqkmc31W5BnQ793GX4bG38y+9NTNTkNPD0zie7MiSPiUNCfr8XH
 TjG6ng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w2yr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 08:44:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52845bd815bso2117711cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788338644; x=1788943444;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=;
 b=iw/27IC5tJdDxDnC52ywOH0Rb+6wNiyZbZ6IiqYlBCNrHCJMsJ1KK11I53Rgn7RHOi
 zUXr+Tz2T7JXknIVuRVEonM9pgFrnGzL9ZTB/4qs+nVlZEVNjc9teI3KQBsrgBeEf4EF
 lfuRw3QYec6Rn/Mq2eXWkwJbPaNXBnHy26Ypm2EjuiGSRJLu3f4nUjHmcHbU3wo4+XRW
 50yPwOKS0C6LsGaSmfZfBN6NIjf7IzoCjxlHjMbpgXFvjYMhxxlkk44HLUPUJxG2a4dj
 4BW9qI4P8c4pOBoNglXWX9yPsGy55ZK25T5LhdgiM670Duq5cY0VEDI60wMDB/rEeeWz
 cfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788338644; x=1788943444;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=;
 b=gizE9xFQ9UgJbR3h/HQsvnWPRrlRVj86z5X4XS5FGCj9v1kZ1x56jLGubkeE34O572
 iySqV9rFbuKV6rV4f+vLhzNU6EWLnRSKpQvDYwORp2LqjEiLVEaSLU2yRvfPZFk4+kxI
 DG+PTek78ewfjsu/KRtyILiOF9N6p8KDlahbGaGI4Iz0YpGdnb9Yb4XodNHjklyjMP6z
 7DFLx5DYRXJzZD3HF+IgtS6ozJ/4ASe+j914xNCg5jYy5BfzhFpxckJJjJTTI8mIbLmd
 2yzuWE65ZYFhFBlKeFNAsrS0H1Lk31dUuEq1ROm+YO23f2bFgkEunkOy/1XRqsifRCbl
 F6WA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXkyJD/hHehOiUqVSfgdXKmzGZWldMgYUQ0ejttvWZX/dykcGe897cfH02obG4UhFQmZ2yB30bUa4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMqPvBIOv95/XbuGt1npA5W0F91129lSDch1gzu4PYpnym7ERI
 toOuSnxo6y7E5fDdcx217mcRpDsXDWfE0zqSjwAKSsrFVIWwtVHIT2RPUFBBeQv2bn+rFnIKIuM
 7SAKwg4MNQetaV1u6G/mZQ+X63kd1Ef4o+fsipQelc35Ct3Gknl2ZzFEo0HVVcC0UkZDrZko=
X-Gm-Gg: AR+sD13gdFXN6vFRuJQTse8nuu2cWORPnRsJKROOq1B1kxvoxYYE4sr8Br+g5bWcvcE
 EXa+e7lrskxtWaZHgMh5WjWp7d6b5z0OzQBs/p6P0qGxK8yTTNt1hqni519gBQ94KPWsNrj09IR
 hZ/5Spe/lMY1E2tyVWMzSP39oqvPFIW7M67Yy3Rga2eRw3V4pqlnvdqqZY8keENLJUyirHxPzJb
 cat9r98MQ3VjuaOYSwFcUCm/cPglaMjRzOYWztmuIWHpYPps3yBXearqJib3/WykG/ziXySzwgL
 fy+8/HxedMGB8OBBkoKIzTIbMGzatw5Q9IXXWM1ipwz5wtwGSZ1CvZzrXRWFTUYJ1M293DwbKUU
 Gmdw6Ohd9XEgISiwVYY7EGw==
X-Received: by 2002:a05:622a:115:b0:52d:9a83:419d with SMTP id
 d75a77b69052e-53036992976mr22276311cf.0.1788338644079; 
 Wed, 02 Sep 2026 01:44:04 -0700 (PDT)
X-Received: by 2002:a05:622a:115:b0:52d:9a83:419d with SMTP id
 d75a77b69052e-53036992976mr22276031cf.0.1788338643648; 
 Wed, 02 Sep 2026 01:44:03 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f895e14sm673780a12.3.2026.09.02.01.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 01:44:02 -0700 (PDT)
Message-ID: <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uKEQQXECUyWOlcY9zVZR1fHdXojbN5pL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfX7hbIowMe5Yca
 d05j5Sc1unDYoYWH+pp9UcQEDOLa5VUP6Qf2UQPE+Bb0t9BpcerkCj5b2kwSKfty5+ABfr66pAv
 S/teh+YBv2UU0DAYuXIr5+7w45oCcYw=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97e1d4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=i7MDaAbus5dcvw8aKywA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: uKEQQXECUyWOlcY9zVZR1fHdXojbN5pL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfX4530NtGusxOi
 vl3gyFCmtIQsYKs709yNzUcxp9h9dcNy4Hz8klQsvFtTAoKStpqefJDZO5jVZOlNRYyUNkxwwhL
 SaiHeSRhrOMCdac8R1Tzs3E1Kg0cLAReaeCfULEOP6+Ferd/dTJPbMirBFojK40NAow3Vbm+nFE
 n5wKC//fSv6uxp4VXVhXVnB6UnN7UqLMREmA4WnAxg/tgYrbksR7cn9wpLB6KhVsELzfRsqaXup
 iK7yx7g6FQBdUeQrLv6SgD3dcwXg6GYikSqK12bNag1nm5Z5nxwRY76tNo4ofn+5QHrz8fMzOT4
 AdaIUeDdaA1tmEoYtJn4vEiht03fpuKntiBiEuvIEfJabEZTRPQUaNHC4k7b5OK1S9VL6c+otvC
 R8hiFe281lK4qe/yECK9JVI95s70J3l0q0mhGyVH/j5d3kCZj8PCw9yiTU9pkEsrB8DyTSEa/UC
 CFO3HykX7bW8Jqfrxxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020076
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

On 9/1/26 10:47 AM, Xilin Wu wrote:
> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status = "disabled".
> 
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.

I agree with the premise of the patch, but I'd like to understand why
that happens - do you have any details?

Konrad
