Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B401FFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140E910E74E;
	Mon, 27 Apr 2026 13:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P4NgRrD1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PPg7vBbS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D0D10E750
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:18:03 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8T7sW2913800
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GlIS0COxbByFQx/A4+oy9WRIq+9vt2F7N2ykLMySeh0=; b=P4NgRrD1u3k9P+rA
 nTOluwo97ECbZPR26h8/bfWGOoJf/Vom2u74VmvlYNz8Wusl7pfINOytYowQ1kVC
 L3sjiVSdO/cY9dX1opJEtQh8y7fGFm3jly1Xv1fAmzMN/CtCwH3wRUP0akUGyYR6
 oeGyIyMSU5Wx3SoGD85Jqn1CBhro+r/vx8hVvloR8JiQqeoft7PrQB544G+oKawV
 IShBka56wwFy78x9dz/b4lLM+uLYoO7G0YiMDPk2JOAABroiNs0Tq47HG+PxoUds
 iqb/gxHbiMN4WLHvEIOmm/6rw5IjqkoFK3dyAqhpbdBQOCcRZYEQxzBRNyVwwtw7
 UGo+9w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xhm14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:18:02 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-94de248f59eso572356241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777295882; x=1777900682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GlIS0COxbByFQx/A4+oy9WRIq+9vt2F7N2ykLMySeh0=;
 b=PPg7vBbSDXyt8vXtt2KkZIvqVqLoa3Tt1v2NdS0Y4gtyoEFniofhxKYbjVlGBpr8gA
 Gwh8ZZ+R+Efxc7sr63VxQ1aeHuga+WgDWJls0oIGxTHS3k4eJdN9xQHNIkeCMVquLqZq
 cBJhEKDMFWhJmS2NtMrA85U5hBolWfDzvY3ua/sybSFwqNSP2SUZVd/oOx08AjXApFC0
 JXZ3Le8qaoKl/JM91NODJKNhVrr10c9oI/VAbqv/MnwNBVzSxh2QgN4KqHgY4RxSM07m
 ejESjGrUA6sUsSj0le37T9p31Z4thSJzini87h0t/hdliaKkSoSDKF90LudRLIgMettq
 CQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295882; x=1777900682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlIS0COxbByFQx/A4+oy9WRIq+9vt2F7N2ykLMySeh0=;
 b=B03tJDDC7347/+e4STe8YO80Iu7usbYZTqty5xHR3N9CkVdWJ0iWTPG32DbDAnazg9
 0k3LUYYFvUshx3iMf4tCm5WLuB4fSzFfmp/5VC7C5b3KIlqnx5QP6TrCNXuCpuelQLhe
 Gr/CNKDfr3XkaofDxgmYBNkLHQsMePBKAHQliBnUvUSVta4sVBscy81LqHrXV4WcRmuE
 W+ZHBCyFiIMW/CRN9faDINK5+YOM16VmLUQaDPFk/kv3oIhjfdvvIZzHFLsLVBQ66L2C
 x0+cefuzFFs3ZXCzV+63t7OXgIwJY2CywFFFGAYlxXO2zbyFEbFu8qgdYzGhkXIvcg0Z
 pgpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ziIWOwf2ZCgtBOgBQ0fVMY4z4OcaFKuGwCRyiLqpjeDpD58smxVON3bAq170tMYFls9UaZXzei2A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRLkYSai/vOk/CWk2oMhB4Xr8hA87gHIiYEmaXhYYjGXk/qjBl
 MLDrFX4rSm/aI+9tfluRU7kJH7URx++OR0ZUlaYNmFILfhNE5SqZ5nQDV2y4TYi0lm35hoES4+b
 2RRFguMVj8ialX2D5GpvuyiBw27H3jU07zlmUqipRG3yBkgSYOvxwC85q7YJ8Bmvf8D51K+A=
X-Gm-Gg: AeBDievF7EJXX0mzA7vPu4LNAC9MPJLVrRJCB9xNOCmMk04hSs9oU5SUSpxeia3zrKX
 jdg7OhS/C5bZLZX2u98ADUZGNh2lMgTzqfQpCEiYv6lGzmpiPApRHogJibgBf2hhJ7rgJI7usrS
 p2LxC+ZXNsxQNGgxj61FsmcNpHJdBkUJJS95OSmtolxURvlxOh0HmCP4AYuwuVSp25TLfaEsJm5
 kXT+fSdTsyTvbS61PPQfTKODnpUMfeVYfk9siYFVdaA7fzRvItVgIRC6u0iWvdIC4tU3PUTpPL8
 mDel+1R9H6ZtJuGKoHcNDMJVVuhQ6JcJcFB9kLgJEaP4agloghTo0KvGkb3gKcQMDJwAIvs7LGt
 fHy7QCuXuHnbYf8bXzA4DV0ndgbQ/SEQHx+EhLXBegIG4aTmOnt4wKvpEYlqwYgshn0EQ1TwQN4
 VtJPiE5ThLV9qG8w==
X-Received: by 2002:a05:6102:8501:20b0:623:52cd:4cb7 with SMTP id
 ada2fe7eead31-62352cd5657mr1122147137.1.1777295881752; 
 Mon, 27 Apr 2026 06:18:01 -0700 (PDT)
X-Received: by 2002:a05:6102:8501:20b0:623:52cd:4cb7 with SMTP id
 ada2fe7eead31-62352cd5657mr1122124137.1.1777295880987; 
 Mon, 27 Apr 2026 06:18:00 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba451210e49sm1136706166b.10.2026.04.27.06.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 06:18:00 -0700 (PDT)
Message-ID: <5d2d7909-9b15-4378-a05b-6803daa27559@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 15:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
 <20260427-gfx-clk-fixes-v2-3-797e54b3d464@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-3-797e54b3d464@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fueT__VCdSUjihBUf0i8O94WmymOeFge
X-Proofpoint-ORIG-GUID: fueT__VCdSUjihBUf0i8O94WmymOeFge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MSBTYWx0ZWRfX9oIBMkjL+xZw
 9RJnePh/OWSV+6ZZ5bpVjz+aalckW4eOQj9gU5WyaPun9WGHMlxRD5PXNNo89YKoBxX8BfImnxV
 mgQpbc6Kh8BAZ92Wup7MPO/jFVdeWqTrCuEddZqi4N+Kiracuk0ZBy0Pd2sOwFLoy9x1nKL7NbV
 qP9tl+Do1yu1lSWSUt4qV33cqitO04JHoC57O2kHczINr0BOIhWoP/23EWdEaawkRKohdjuqpK+
 SHnsA561vjLzR45vZY0+EU5B/3r4LvnjiEwnEQ54DCwChAQ5PiVj30uiAF5ESGXwdV4myJafaVL
 ZzYI6QP43bz3wmIs1OJMtvW82HI+cUTh2inWqvMURXbZ0uD1lV13AFbmUZosneV4aBbWw601gRt
 5dje2hgbaS85Axp312NemiGJV4Ai4Ehf2ZH5GtV+z070A6Mz/ECH58OyLwRlYQc7XyS2VGubFDX
 rHGkL2LBtIUCaCjormg==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef620a cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=FUsajQaAIeak7Cqb3WoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270141
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

On 4/27/26 8:38 AM, Taniya Das wrote:
> When the clock controller is probed with 'use_rpm' enabled, the
> runtime PM reference is currently released using pm_runtime_put(),
> which may return before the runtime suspend has completed. When the
> clock controller device is registered through this function, calling
> pm_runtime_disable() immediately after pm_runtime_put() prevents
> the runtime suspend from completing, leaving the clock controller
> active and the HW rails in the ON state.
> 
> Use pm_runtime_put_sync() instead to ensure the runtime PM “putV
> completes synchronously during probe. This does not have any functional
> impact, but it guarantees that the device is fully runtime-suspended
> before returning.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
