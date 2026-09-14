Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D842C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DCB10EBA8;
	Mon, 14 Sep 2026 16:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOOo4VER";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+eonTD8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187C10E1E0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:27:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0QV2674431
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hyTPgK92z//XO4ewrPGEMLjpligNbIo4paEWK12IK5g=; b=TOOo4VERQOQtZy5n
 /n8GhNyA3QJlNNbaRErJ/v4xKeWDT3KDvFUurEOKTSqo8bbCOBwVM+QifMR+GwHq
 dpDFCNhzFwVR4hq/j7vfsHwia7HrWzTtyaGEYfpmmbH5mE5pjDXOuDENlHSWfREk
 Tl8XIQnNd1SSIaaB96uOWvupMVPO7hMyWNi+edre5hHoDCGuRbKmtZPMQNaB91o4
 n2Q06MNvj7L37bGtfndisK2WvUDOKglExgLKG8SE2GcmBBV2G6Tuq8m0MKBNEO9Z
 CJI4o7iAmE4kpgPo+71ZwSWNH8/3ErvtqGhQPG5eijKzA/BcjGuBaK5qGwnClc5e
 1V2hLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs9ppk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:27:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso573985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789403231; x=1790008031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hyTPgK92z//XO4ewrPGEMLjpligNbIo4paEWK12IK5g=;
 b=W+eonTD8v5BMLwRICUFVnj63cK6XZUxeNS0KD9d/5Xl/mCv7OvoF3dh8q5vs2+YBJB
 5CvAFCO5aVJfnu+TYlyw7QaGxrJ9YX70Oibp/sxsD+ooxINOzJ6qIV6LjgNCYc1NNWKt
 4fq+8VDRJk9kBgMe6mZ+/IJ/8ym+O+ZEZ3dRMmB0I0jex3ZUSAO4aS/X7tNiIuCv+J5r
 qbkh88v1mpZs66sZbk8i9p/kjflQrMpDTkOdpddMpHwsZLKE3iDn0Fw8hkAf+v7SVbtA
 NIxUIAVSZnFs/lYXJsy4Ppwy2y61ntQIndO4baaxAj/cWQSv1bqQGBtFo6hW2Gn+E+Ze
 mHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789403231; x=1790008031;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hyTPgK92z//XO4ewrPGEMLjpligNbIo4paEWK12IK5g=;
 b=Xj/69KTlKG88w0ah3GmaFVibPD6X1aw/TH0wmbknD5IxDhc0m3N5OJ9PHFNj4JfZpC
 S9v5vo+YArz2WH3keizXuFJakmJR85BNvyWNSjoiB2jG2yi9bHKN/q6/bZREa1zUSiz2
 R+vspgPz5+srDatRXjEEanYBxV9tHM6YvjZXan0sOllXX8cdv+h72KefcGahPM+HloeC
 neMQ6sQBKUVCLuq0tH6ZvV92amHtZuaTZI4OU6nR6908dfpghwg4IREICoAD8AqREm92
 33sKgqmRAFbYiVM60BMCjEeSU+jlHEg1X9XMYz6xN1wuVuOR2mrWdGRGs1JGE5mFDEH4
 fHLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByGkAHB7Gh1RMt1bKwVKvX5AqjmO5yz15j5s8YgVBhPQGSwIpt+MjWYVKC/WyzpUMlIhQZzQBazZh8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNXu587XiQ2AbEJrEFexHaFg2+yCUMPi2lCLgUeuG0x2xoVMzr
 mym0rTSm42HkkFo+b/Lynv/OUxISwX2376i/9/Jg6sXAD68UiPl1L4RrREJJpJbTczioBBy38t1
 zacYypqQGDKoQj4MpkorWclnjGMILYo+WTHKE+GKdIOONvHWwDPHzVhQ8d/n4hJT7K4o6YR4=
X-Gm-Gg: AYBFou1aoRG1k5aaer9GpUDyyfuGkFz6IfggO4Q2lX40eIB1IyD/GtGHUR92uukBb0S
 /fJ8z2GILxt7Fddat1v5E5hbFvVtqdQLKyMTfrP66MIApBrVL6TO5ElwoHNAP474hlkG7PGw+ZC
 s5oYt1IHN7Yiti9NDro/IcZjfCCibfwBEkoxgsrx5BhcmLVajRPEEJ1kMxQKZfKxoYwl/FsQdgO
 Ln5Xyi8/YERMiLfAzo5dgGbWBEg09k+ZK/yng8PY1klOS4+8BvbQZLoSF3KUuGSbtA0V6etH+LK
 LQgkQznNhrCdAdUy2GtSiXL0nWD7OnAUkENPAa5jrHvwMJU9EzRt9YPuYaVGRXOwC/Fc8wBwvJp
 FmmPpLtxQUJyOEn7SOZ7qtvE+z3M=
X-Received: by 2002:a05:620a:7018:b0:939:fe55:402a with SMTP id
 af79cd13be357-93a346fa60emr19926685a.31.1789403231194; 
 Mon, 14 Sep 2026 09:27:11 -0700 (PDT)
X-Received: by 2002:a05:620a:7018:b0:939:fe55:402a with SMTP id
 af79cd13be357-93a346fa60emr19920385a.31.1789403230649; 
 Mon, 14 Sep 2026 09:27:10 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-49e7d67de8asm4247995e9.12.2026.09.14.09.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 09:27:09 -0700 (PDT)
Message-ID: <f22c7346-d597-4e4f-b498-d8a46bee400b@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/panel-edp: add CSOT MNE007QB1-1 entry
To: Doug Anderson <dianders@chromium.org>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, sibi.sankar@oss.qualcomm.com
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-3-srinivas.kandagatla@oss.qualcomm.com>
 <biywo5isdeagqu323ozaleeakngl4sngps4v7ngwqo23ju2sw7@jn53hxxuccff>
 <CAD=FV=X-Te1fieogNaMuyFAa2q33RKUCVXAUFcce_r7csXAwVg@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <CAD=FV=X-Te1fieogNaMuyFAa2q33RKUCVXAUFcce_r7csXAwVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzNSBTYWx0ZWRfX8ez8teRzU5Jg
 c8dowYPdH8F6F/Qqbz++VG/Ot2xXCRYqZB94o+1Z0BzrmcQALZPkVyoZ4Mr/jWwt8M9csSCPTv1
 +rdTPSqVqXSrSadXLrMbeJbVJrevfLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzNSBTYWx0ZWRfX80XmCNqzoXkQ
 kGU6J1QfNcFsEOCFG6lhuOL0kulx0ZjRFTuEbwQYCliuVWaRzIgkqlWJEdWZiSiJDR/A0G4i6U2
 VnQe5JbRjpgFtAW4PogbFif+Vu2cploOAhcAJtnUmKn+kD4mXpnBVNOzdB0gDWrisJzwOOGhRwc
 +K3eqM1BbAjXYxnlH5IIxAQbGVX+D306RBwntMEVkFeMAYULhZiFB/q7rOOos/sGlI9X5cptPZ4
 6/ESAH0SJH9dKb1Z5uzjsab4fPNjerL6H53ieLxxGFBKafdWWCENpcgNQJIzjabIpt85kz77KMw
 dTJ+mAERzhqM2PKJNDq4X58fb6a5gR67u30oaIHCPhW6xBsMGNMFdqcx+ksIOzxKqBiOlTEcqpN
 OMOE6qWalshhio/LuMPfFWe3LE12myj2+uYZryqoPPzIoxWatGloBlXmJAy26gQyW3l2w+u8/UJ
 /jO5eHVqhZyAo0FsKxQ==
X-Proofpoint-GUID: 3g2UVV3esQG5UA_U6iBrc5rFtW-7ZaVe
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa82060 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-qWaGmECaF3vQ689P4QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3g2UVV3esQG5UA_U6iBrc5rFtW-7ZaVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140235
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

On 9/14/26 4:13 PM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 14, 2026 at 12:34 AM Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>>
>> On 26-09-13 21:18:33, Srinivas Kandagatla wrote:
>>> 14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
>>> Panel identifies as CSW 0x1465 over eDP AUX; uses conservative
>>> delay_200_500_e50 preset in line with sibling MNE007QB/QS panels.
>>>
>>> Assisted-by: Claude:claude-opus-4-7
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> I think Doug starting asking for EDID dump in the commit message.
> 
> Yup, please send a v2 with the EDID in the commit message. See all
> recent commits to this file for examples.
> 
> It also looks like you are adding the panel without having access to
> the datasheet. That's an OK thing to do if you truly can't get access
> to it, but I'll at least ask if you could get the datasheet to confirm
> the timings...
Unfortunately I do not have access to the datasheet. I will look for it,
but if i dont find it, I will send out the EDID dump in v2.

--srini

> 
> -Doug

