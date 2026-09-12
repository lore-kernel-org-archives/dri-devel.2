Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA7CC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 19:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8779410E2E9;
	Sat, 12 Sep 2026 19:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8Facd42";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5H9O3q5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CB510E2E9
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 19:49:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CI4kWA3220456
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 19:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QZs/Cuv8bZM1WSmkh+OPZ+1buGFIG/hn69EA/BZOuZw=; b=h8Facd426qO+EmAy
 SqPyoxBD6gqSgEaMdE+GYatPlwYpod3dUvM3FpNJVuzqie1+CV56F+BF8LY4c29E
 JKuGISoAP/AlgRDSh48TOUcw0lTTS6xmsWOb7qztyyKyp3NsG0HCdGdd4ZxV/2lX
 Dfg3FqrMFPL8h1CS5rT3v6vSidl6EDHXBR8bzXA3JfObVHP2JOnJzKze870W4UeU
 OoZZUgZaUOvPyKsjRT9wZLTTVEehJBaflOwDiqHp9ae460E7d2HNo2GpcGtmjJax
 lc5KqGokyaWS2CPcySiPsaZOIoOdvJ+Rz65+E9Mu1/hMnpkBOOA1OpUywdwzriaV
 4Az7ZQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd1ttk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 19:49:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8645a62066dso3867547b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789242597; x=1789847397;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QZs/Cuv8bZM1WSmkh+OPZ+1buGFIG/hn69EA/BZOuZw=;
 b=P5H9O3q5/XLx/etWqi76hpdFHVU4XEZcc7IeqtmsSt7Z3kyW33dYIbhtOMSmwuhVZk
 NKplb5ThyWG10Z2DtgP/S6mUjxBi7TJNNiic2o1g0uGGQznhyXax/SJqzXP2CxfB+xTy
 uglxYeOun4+XYhIPE2Mdwdpq9ZCiP8DOXp5/PLR1nAt2WVi8hpMpYC4y0LEnyh5RRpG3
 u0UWsBRtTS69/8zaXdv4nhGoVi3X7OVbtyTLuS6YFCeUQB/nktciVMrG9avPMFLFCQSa
 x7ORgv//XD8CNxqb5GlokbaG9NqoLV0TdGH2jdM2nAj88E6ugeF22YKXLZp2yANkJy1t
 H0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789242597; x=1789847397;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZs/Cuv8bZM1WSmkh+OPZ+1buGFIG/hn69EA/BZOuZw=;
 b=MPTSjaGGi23LS0tVZMipkJKwEMkKl5CNu28HVKfVxcPZ2IjO4CsCg+TShVSFwvnPos
 ZS53w+5NK7/qtwvTZEM9JA24jvHT5v44zHIkjRez28Zkh+5DE/LEDhbnCEpiz+dRzW3E
 vyhjxpCfvQjT83q0KZ3WrQxmH+GL1S3hXv+AOyKvyVu2S9/QYB9A8o+ffmnTjukNE5UZ
 5KWv+rFcgVxyRsLzEZACQ7+dJIzqosJTcMWCKiQQgK/2K8B3A8E5grcO/M9R2D46l5jE
 /cmfvcRypRI2EedaDmnS1HhXkpAcV0FZgtnYFF5m8SVLwBVkzYWGKfyTo9DY9WHSz9bu
 4Nhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtX++w4KLl5LThSzHOZkbqcC4LYbK6aAYFylmkH9YLGjK89lUyAD88IqNvxbyJUGk9m6nz6MlVljQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mqENjC4ZAzdrsjK4M9q//AcyH3YWykGWdovC9JpJsACojxr496
 cRbX+mFSa7Mj12yKU5aUV0LADTmTT77TsGQtrR3ZtRTDzigWpm+Sbek5eRcanIHsyYWZpwq3uW9
 VckPvfYdoCH59xqDVWo1huFGblqy8qfEF1jie4wlHfyB/6epRWCCbrrqiOplT2aBY5ZBxFTyRRS
 PKyYIzmA==
X-Gm-Gg: AYBFou3k/UPwKMGm150ydo6rrdK9wqUFyn9QkIvlnoGrtq+sXlxQ3YVUargASc95pfe
 /+DfeoJrzpZFpNUM+4V9ADl11O92UYvFz4LjPAYyOVYsjcPmjFBEel5VfRrozJgx6o25OpDSWqL
 TCIB4ghfgSfA39aieMsrkMeYF3TYg1OV8SgV/Lky3NZ83FE0m54AmjVN83oYyRBvQbS5zYLxKQK
 /jlDVgmBiCAD+D9MQo/xK6MxVrojEwWDjpUWXmwL7wKLCOvM7jrInOZleB9+uk38c61/1Mx759e
 G0hPNuCOG+IgWzHy3qc/A+/c1eECE7EgbwJjZs0tzOdafeWjS5URBPKLMf8QmAEAYvhkyMt/wMZ
 3CE4=
X-Received: by 2002:a05:6a00:178e:b0:868:eabf:e07a with SMTP id
 d2e1a72fcca58-86b31b08f1emr15844462b3a.10.1789242596546; 
 Sat, 12 Sep 2026 12:49:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:178e:b0:868:eabf:e07a with SMTP id
 d2e1a72fcca58-86b31b08f1emr15844431b3a.10.1789242596098; 
 Sat, 12 Sep 2026 12:49:56 -0700 (PDT)
Received: from localhost ([155.117.96.35]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b250c544bsm2582612b3a.1.2026.09.12.12.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 12:49:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Sep 2026 03:49:51 +0800
Message-Id: <DLDLKBB53ZVF.LBGN3D7WD3YD@oss.qualcomm.com>
Cc: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Linus Walleij" <linusw@kernel.org>, "Roshan Kumar" <roshaen09@gmail.com>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
 <CAD++jLnBPAw9CJ4JtZt46yBd7+UEHYA189Dma3tNfuV=wu1TDw@mail.gmail.com>
 <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
 <178915364143.207017.11386693869817053993@gmail.com>
 <CAD++jL=9bEn2iG5q7tTL63_mdBHPVWhK7Z7Xm7Um8LJKWSFEyQ@mail.gmail.com>
In-Reply-To: <CAD++jL=9bEn2iG5q7tTL63_mdBHPVWhK7Z7Xm7Um8LJKWSFEyQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa5ace5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=vMSCZt8JIpogJbZyvqoA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDI4OSBTYWx0ZWRfX5FtfoYiSChvv
 jgmywDFzzZe1psQZMIsNupjCMsDH3tWeIYiCqXjUdtoOYPParrEar7CNDMG01BwpD3SwescHFV4
 PNTAiFigu1eQ2w/jOFVDDo84jUJRXQT/Fxz+vi5k8RQu4B074x43O1SQ6XQ7B4WCxMpkOXsT41o
 3hn6ssx8WIToMjyNJVW9pDYV2n1kCBJdEZeBgWrPvNIYgnGNDam2MVOKw6/NResuw78LwEXNI4Z
 JDTcMwXLKVVPthF8W8DrbSe8OodtkzGaJnMOM6msuLsQSKUmOvLPZxamoOHQOYkMgFrp7rdZX38
 EOF0TJUKDrJtYSZ/pCphLg3GbuegqwRjo7kG/31lCEVNEYR1nY/pqujR/ieGBBZdm9exQ49mFoF
 1/T5wlg0g3713S6rETKgar8RW1xUdRBYeVYt1thYI+q0patb7GW29YuNVcFhDPuUKALgEFBYWUu
 cjEnkU5ZOzX5aXH0FeA==
X-Proofpoint-ORIG-GUID: L6s30Ga3TcqSEtsNsuiwQYetHcZCpy1D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDI4OSBTYWx0ZWRfX6Bc+2MHNiZq9
 M/H8x84eaeCAKG1vz/t2dgRree1xOpqGKxkdhnXdFXFheBhScfjIq7PyLrH4QxrPpadYsQF1uES
 if+sm5lHSQEhLa6dQuri21axxeTYBeU=
X-Proofpoint-GUID: L6s30Ga3TcqSEtsNsuiwQYetHcZCpy1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120289
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

On Sat Sep 12, 2026 at 4:05 AM CST, Linus Walleij wrote:
> On Fri, Sep 11, 2026 at 9:07=E2=80=AFPM Roshan Kumar <roshaen09@gmail.com=
> wrote:
>
>> Not quite. I tested the newer iteration attached to Thomas' earlier emai=
l
>> (patch dated Jul 27), which Ze hasn't posted to the list.
>>
>> I also gave the v2 4/8 you linked a boot on the same QEMU setup and it
>> behaves the same, so the tag covers either version.
>>
>> Tested-by: Roshan Kumar <roshaen09@gmail.com> # QEMU vexpress; v2 4/8 an=
d the Jul 27 iteration
>
> Aha I see.
>
> I will wait for Thomas & Ze to tell me what they want me to do
> here.
>

Hi Linus,

Please go ahead with the v3 patch attached by Thomas, which corresponds to =
[1].

Thanks Roshan for the testing, and thanks Thomas and Linus for pushing this=
 forward!

[1] https://lore.kernel.org/all/20260727-drm-simple-kms-removal-v3-4-cd5dc8=
9858c6@oss.qualcomm.com/

>
> Yours,
> Linus Walleij

Best regards,
Ze
