Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3657CC6B3B
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED96310E042;
	Thu, 15 Oct 2026 09:45:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F153F10E139
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:45:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6u0sx2121439
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=h+FgW93lIZWkl4JuJ0zk+Xr8
 VIgEcu5OQYc43p0CbhE=; b=gMpA6lx+13WJeyGV6JAdEeHHZRlhyfCnTSgbygGy
 E7mWXkhSxHSeaC5OS6wjiSmN2WJcUNy0Whi9dRNs92KmXQyuvpNFFlnBaK74ToLu
 6mZfMZ1scobI7uOLGI0hOkrJKxUGFUyMyGlbZk3B5lSwPr537MDbPxJAZjZah18y
 xYv8QJWXuIUZZaAnaDid8GGVoVERbXGF2e2iD2lukpEmJwleqBS6Sp0Vm1kEgS+G
 BSdxXIzlM6NWRLuJKfmTDCA2nAYCBXuMeALqVw2bMVcrbP30drh8WYqOoiLW37k8
 3eueEP/a0HH4PW1Ohmekrd4Wm3+4k9RRgQiX8BjeYGHY5Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn23km-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:45:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so379743185a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792057500; x=1792662300;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h+FgW93lIZWkl4JuJ0zk+Xr8VIgEcu5OQYc43p0CbhE=;
 b=Zlhp2EnGKaDaY+CdXsEvmpVHTlsDjGf/zM6CHJO8GCOXsFtMuHQaIfFa6d2FzTgj0Q
 t89Wu8ewwr+UVC2lvaAqt3Hfu40kDde2Ui2PpFUWeY08LkmNqbgCr1yW+vzxXXHiqO8B
 yrq3MqBRlESMgrwHgWVO5PuTHdHvFsXXV5dutd4Qpg2ykqm07EYB9Yo+/SBPIEK8dBQF
 Ww1hfuixR2JqyCzsBj2YAYzj+a6ZS+K3WRnPsoAWd4KncKHFUxjPV5HDGuS19/WYNJbK
 gdqSOGL7nnMQRZ4ReJTHECKx9fbIcT2TwSV6nTg+Gmf/BZpf/7kGer8nXRHzOcxIeZUT
 QF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792057500; x=1792662300;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h+FgW93lIZWkl4JuJ0zk+Xr8VIgEcu5OQYc43p0CbhE=;
 b=iYr4rtLuEIcrQBW+6BRtm+PiMjCVa+NSfzTJYI9xZSvlLNCuV1ik47BTU2pKJxiMeA
 JePjFgkOzFyhGxDpo89Sw439/1wld+G96ffyZpBXQrTBP9RtOZdIYWozXOz4c1/UaeCV
 bpaK4+1kGzAjwqsE244+i18X0k0qpjcOxas54516DYr7JqbzTZuWEGJm31iVRsnJQwsw
 f+ajIfJbWSe8c03JEjfVtfa/c8GYzJTrSF2p7sCFmpKsfvH2SJllqzRVP229/DFtGU6y
 LT80z/ADMpK/YqklVeJZ7Det3NexrRdyDNZVfzPDi7vX9CirqEEQO2tIzXZXXGWLuCFG
 X2nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzML+70rYz5xMeOYQXtzElRvKsZ3OoqZ/0bPCTPfj8KHrl5CJCaQ24vjthvYof+IP/UQDzUvqqaoMA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmKjSfeCYypE2i05sJ7IpjJd34XZpwuk7p8N903yYLq3wD3oVJ
 tTDQOLPaHakyt+BTjBXHfNoZOa2MDHr8UeuUX53G+427QnyICSODLt9ApXtVqc6Jg9/G/3omIYi
 Z9BmMV0qaVJu0LCPmy1NgYxsT52y5K4PRj4HNc2seCubHDQfOvYLSo2fnFxEPZv1BAb/88vQ=
X-Gm-Gg: AYBFou1AblJPBqQEY9ZcQf2ZwwDtAmER9dveDKorKWn+jpttceKgPN3Fxp+AVMT2azc
 VnuT2Y1SqMbdT/vAbgeZBfVw3xFm2dkNN08fIQ4iWhCh+3J/1fYLejpUU2sHxUqVRtYLV/luYOZ
 ufyPtfwOalNe/SXmM0p+q7tn6DVlVWSFSF+Jx3x3C+v0rs026CwXHSY/fhQjM0d2qSEVt9Ql8Jp
 Mi17M6RpvvLA3cHKhAmtinHvD/U0LOgG5S/n3gNpdTOnCjFgitHSLb34h4xWYmvEPILEEkSsr/K
 l9DH4uH6Cp16OTiWlFfsc0SLj31x9Tw65vZsMLTCsoM43kqFLf7zSLOHr3paoknQ/dcmN4DqWwj
 7DG0n9ep6gMfy6K2QGgj7DDwh6pApr8yPg0aWSo/3nk1mcs9oiKCzBst+XPcpUt5dvQ7ZVShpKw
 b8S8J+ZtWdUgMU
X-Received: by 2002:a05:620a:4613:b0:93c:ab5e:2314 with SMTP id
 af79cd13be357-93eb95e3828mr2851430985a.7.1792057500168; 
 Thu, 15 Oct 2026 02:45:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:93c:ab5e:2314 with SMTP id
 af79cd13be357-93eb95e3828mr2851429185a.7.1792057499630; 
 Thu, 15 Oct 2026 02:44:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab1169d43fsm796131fa.23.2026.10.15.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:44:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:44:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
Message-ID: <6x7y43ldn6kjxowm562icamjaajnxlgarzbelqg4wkgvf5vbbo@x4t3mu6f44wr>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
 <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX/CKOytU0ScDC
 FE4+qaWFJyiUd1O0egborLd6ux+YGhmUPchzR/7veHwxmn6k4RdM1uHbXkuVtpa1wWt0hac2k/J
 /Dw8urCmTKIqI4YsiR+SVmX208TDzA9r2eSQUzis9ODxNibUOMmbx+x3OkCUF/AB92DGVKDTpFb
 E9BZWfck2ESOnMnTUvAKFFMSD6N5iVbmwukkRieF0H3KK1chCuQkvlR1eII9CDuEsnjXCE+tod9
 x2wm8Pk5YC9rd8nsryqOx/ss/JvxxZQGNuTcrqrjGh+Mj1ch+lFuxq/o6tcqRpJKTjGC09wXtk/
 GxjEAclEXV5Ot0twvV7VYPNRz/vfwr+j6Hxq68t3WHyuBdqz2mOS2isYW3v0neFNyUYh+5sJFS8
 RsfN6msgB1Wa4o5q9xrqP+Qhn39iXBFUWFJKyJn/vhdLghXiuktuDI5iywW4DMxYgSHP1OzLNZL
 q6xQB7zE7+B+/oIn5HA==
X-Proofpoint-GUID: ShUNfkFCIK4l7S31ISjHGShmSp4I7fFM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX/YwunjJJAvyb
 hQiGSDQCY6bdMqZP1hz2StZfkLJ7d6cwvqZyWOnkX3nJkdyTmQF/gCCLkJ9Nl8V/5sAwmQ4akwD
 Hzm5Ns/+bDw1iahPCQnrrxk+DE/G5Ow=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0a09c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=DzZZqAc8IDjE5QScHtAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ShUNfkFCIK4l7S31ISjHGShmSp4I7fFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150038
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

On Thu, Oct 15, 2026 at 11:11:58AM +0200, Konrad Dybcio wrote:
> On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> > If the bootloader leaves the WLED module enabled, the OVP interrupt is
> > left enabled at probe time. The first brightness update then schedules
> > wled_ovp_work(), which enables the interrupt for a second time and
> > triggers the "Unbalanced enable for IRQ" warning.
> > 
> > Track whether the driver has disabled the interrupt and only enable it
> > back in that case.
> > 
> > Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> This was merged yesterday:
> 
> https://lore.kernel.org/lkml/20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz/

Nice!

-- 
With best wishes
Dmitry
