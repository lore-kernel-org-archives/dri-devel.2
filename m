Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059F1CD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB5110E772;
	Sat,  6 Jun 2026 12:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlVCOqnv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqIP3dCS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0F410E772
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:13:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BHv8I1252232
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7SqtGoBVXuWmBmxq+hyY5Aee
 WbM95T5UuiKyeUwR3/I=; b=nlVCOqnvI9dHtCJhpU6XQbAxyVBFHxyqOtS3JuvI
 rkARy5cPLRffcwuHgYNaMS6xu+CdLUfa0acd6SWVE+qiLP1UMRVqx8g1E7ntTs8f
 99jmN4IiYBOIo23znWntO6wRixUgGKJmzc+OACjiiEKCix0YBh5pj58P76SSa0wx
 1+F6tEGouLiTpaJQesrbCXBVDfrfchaCxsZ/4A0/oo846MDDWEzFBRRYaZFMJiNy
 45yZZtiwF0n5yo+IOV/XhVG8oaMxUOHqrHjPzHCyBVdzdH9scRA2Ys2wZBFRb5MV
 CjYBn25wl+UY17Q3Tr8tdjtaWyvUXRBv9cMVJymKNhOWuA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf175n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:13:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9639d763d99so1433648241.1
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780748014; x=1781352814;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7SqtGoBVXuWmBmxq+hyY5AeeWbM95T5UuiKyeUwR3/I=;
 b=iqIP3dCSAFn58XCMdaNfyVrvPxewuWR10BPMj1RkRh2cynDDJEQll0JH0EG9FhdqVl
 8qSE5AcIrpxr4h4q/S4QZ9XJDlqsRF0PryDrs7qDVDXoPl06jQLgX5SgV4MjbgtNUn7r
 LGStrEPFY85Func7a4HxnNYQAsDdDS4zqVmyalcRbAaAvOq3QRtXI7nzcPc0bt354DSA
 tCMw9ump+mAtVRAuuWCYbHCZ/DEjpEiEt1iEd82u4rosQbuUmJ6tUN3V//s2jkcbgMsE
 OQBcRSJDZ5X+FAr+s1MZMG2y+i/9TaNe/XdGZC+HArZNxSwdU38A++D1N87xHwNAVQiT
 CMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780748014; x=1781352814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SqtGoBVXuWmBmxq+hyY5AeeWbM95T5UuiKyeUwR3/I=;
 b=CqBHJsX66/RYM+anSic1Pp6uwGOMJ6Tl6LU+E3L+h2k6GTZ3OlpnUy6KDQ8m9TCi4m
 0GdRNLI/+O66M4dwS/CIohH1gSGtWxSwDC9P2Ok8NVvo3BruVYSCg/cGFCRQ8KqwGJmf
 2bTbsQdr6jYON/z+3ErDO2FIIHCNn4CjrBOVaop5vDjdLCGnBgso9qoSizGls52gZup6
 Amx5KolTuQixofS1ZlK34QKWIz9ph4z2/KW+gGcESjJRjLxDmMwnyTqxNeT8clT0sOem
 3slpM+w2hsm7xA06YDzjtI+3aZPtjUKQRjuvUIylSiJWE3UwhD3ahEsu6l8rZ2cuZ1E2
 A1VQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MEgyEUTKX+12m+IvV3+But+AuJjAigPvKRyC5jiSDp+SixdyALktiruJi0DmxAa85aOChLKW86gA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmjCps9Ck5/0FQfRv/CIp32pw4TnBFiPYUOiX6MfmNYbmQLUlF
 U6GimA1tQiv/n9x5q4/3oWvLEtotUPwaGifyailyXGz2jl78V/GowCyZeIDfuHZvNQXWvlUsXql
 zh1I64ZJCGOZ0JQwGxMLPW4Syq1rYuMISP6PKJeNaCp0eTXteWCS7TTQV2D948dAsy6r/5CI=
X-Gm-Gg: Acq92OGdBXwIPcoteoOgRUfw8Jd55Fb214tp7EYbMpDJ/A+bU8dErND9Wrct4Itdm68
 8lErvZdI3zCRcRpd3biIQeACP0IWYjpoQLx2c8krDVEwnY3ZCrOyYhmqWZm/wT2vn0ZUR75hwfQ
 ysJiDSzOnPQV4tkV5nKnz3xnz8Lu65CR3AvPIxqEW9MUYNMe3Lp4/P9dp3Luvy/yRcvdReZ3XC8
 xhaXok3TqQIPEcsJXL4jPc99TIqXDvGU05SmAdaY1t7qNno4USdgoksy9Rqvhajx2I/Wr49bEz9
 Pez4FKAwihsbMYJqk3uXdwwFb9cjFifa7TPIrQmWBwkbWy21PQK9TtndWZWEgk4CnJLDZlLqWwq
 drn8rr4j31YGSxg1I2p1ecELK6Eq4yNRc0Ulu9rIOMWzLTBG2jGzJWJTXtoxjrm6XECTrarLzYZ
 ilT3bFQJ85TUqQPECuH0JxnwnVZAIk2TEonlbUFnyDIngtpA==
X-Received: by 2002:a05:6102:148e:b0:6a2:b441:e0e5 with SMTP id
 ada2fe7eead31-6fef20ffc89mr3999890137.8.1780748014368; 
 Sat, 06 Jun 2026 05:13:34 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6a2:b441:e0e5 with SMTP id
 ada2fe7eead31-6fef20ffc89mr3999874137.8.1780748013932; 
 Sat, 06 Jun 2026 05:13:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396abf66ea9sm30824371fa.2.2026.06.06.05.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:13:32 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:13:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Ayushi Makhija <ayushi.makhija@oss.qualcomm.com>, rajeevny@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
Message-ID: <aiQO6RdkqVnBuzp6@umbar.lan>
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
 <20260519-curly-courageous-sturgeon-2facfe@quoll>
 <dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com>
 <yn7rwuguaqliovlyukcj2olxby7zerv57na3jf2pgbke5zgahk@aasd4ojwdy2u>
 <a5313752-17ef-4d00-9f61-7717e4f06982@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5313752-17ef-4d00-9f61-7717e4f06982@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a240eef cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=IV4c8OSHAAAA:8
 a=t1hzSAPpwDwDAyt0_CQA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=Q6n48rkgcAvIKCAITAMI:22
X-Proofpoint-ORIG-GUID: pYcE2w9FXCPWiiFFK4VseFn6qHdWYQsO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMCBTYWx0ZWRfX+8jAvuNFig4I
 LHOyqOeKOF7ykf53l3iGcbKb90CLY4iX6iZ22drauFvyO+PwMyvvudYsgy/onlRBg5k079T7RoZ
 deiC3gDmTx0YsXhQnyMBMSIRAlG26FA9cWUNxbY8oGoM3BuTlDMfG0YV+MtbctTiUdksGpGsbXD
 InpIydenyykE0bkC3YbTHHDWr6V6Rmd1kH6IMINbImjLOSAWknFTbh/r032NtV0t2lDJqmAF7Qc
 biGCfT9VqDyv7ZiXkx7UkC8gqdjlQaE5Gg3/uVkEoY/nQXoo9pyKkhqo4zhot71vZ+op9FxBuFc
 Ecf2q/mr0v1q2PSxDbmJDf76epKkMUwn5IMs7W/IuHKrSYUocJ70AkX7jDDs+XQo7NP9bkhl8OR
 9USrJqvZTnJwZf278G+7JtyVkEXGU7I+nUbUgU2XmKA4xxhxvqSHNPf4dQFSO6cHzt80RoWQMHs
 DOB5TAZ65vyyvNLGE5Q==
X-Proofpoint-GUID: pYcE2w9FXCPWiiFFK4VseFn6qHdWYQsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060120
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

On Tue, May 26, 2026 at 04:02:45PM +0530, Arpit Saini wrote:
> Hi Krzysztof , Dmitry
> 
> On 5/20/2026 6:56 PM, Dmitry Baryshkov wrote:
> > On Wed, May 20, 2026 at 06:10:57PM +0530, Arpit Saini wrote:
> > > Hi Krzysztof , Dmitry
> > > 
> > > On 5/19/2026 4:02 PM, Krzysztof Kozlowski wrote:
> > > > On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
> > > > > ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
> > > > > The DLC DLC0697 1080x1920 LCD panel is based on this controller.
> > 
> > I can't find this panel on the DLC website. Do you have a pointer to the
> > product page?
> > 
> https://v4.cecdn.yun300.cn/100001_2012175013/DLC0697AAL21MF-1.pdf

"Invalid referrer"

> > > > > 
> > > > > The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
> > > > 
> > > > If panel requires it, so should the binding.
> > > > 
> > > Ack, I will update.
> > > > ...
> > > > 
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +    description: DSI virtual channel
> > > > > +
> > > > > +  reset-gpios: true
> > > > > +
> > > > > +  backlight-en-gpios:
> > > > > +    description: Backlight enable GPIO (active high)
> > > > 
> > > > What is the name of the pin in ili7807s device?
> > > > 
> > > Display daughter card has WLED driver as well as LCD bias driver.
> > 
> > What is the display daughter card here? Is it a Qualcomm board or is it
> > a part of the panel?
> > 
> > Also you wrote a lot of text, but you didn't really answer either of the
> > quesitons. Is there a GPIO on the panel connector that enables the
> > backlight? If not, this is some external supply on your (assumingly)
> > daughter card. And it should be modelled accordingly.

Still unanswered.

> > 
> > > 
> > > The WLED driver's Enable is coming from WLED_P1_EN and PWM is coming from
> > > LCD_CABC output of the panel.
> > > 
> > > DISPLAY0_BACKLIGHT_ENABLE (GPIO 91) of ITP baseband card ==> WLED_P1_EN of
> > > Display Daughter Card (DC)
> > > 
> > > In the display daughter card of Shikra ITP platform, we are not using the
> > > external PWM for WLED driver. But connected the CABC output of the panel to
> > > the WLED driver. Backlight update is happening using MIPI DCS command which
> > > is driving the CABC output (i.e., PWM for WLED).
> > > 
> > > Because of above HW configuration, we need to enable the MIPI DCS brightness
> > > update on this panel. The below command of dlc0697_init_sequence() is
> > > enabling this.
> > > mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
> > 
> > So, this should be then dependent on the presence of the backlight in
> > the DT. Either it is a panel-internal one, or an external one.
> > 
> > > 
> > > 
> > > After checking this, I realized that this panel can be used without the DCS
> > > backlight as well when it's using PWM based backlight control.
> > > 
> > > I can add `has_dcs_backlight`  in panel_desc and set it true for dlc0697. I
> > > will update bindings and add backlight as optional property.
> > 
> > Why? Use backlight property instead. It's already there. Anyway, you
> > really, really need to describe the panel in the bidings. Not your
> > daughter card.
> > 
> This `has_dcs_backlight` in panel_desc will serves both the purpose, as for
> our current platform constraint , we need to create our own backlight.
> But this panel can be used without the DCS
> backlight as well when it's using PWM based backlight control.
> 
> So in this case I need to implement the backlight as implemented in
> panel-novatek-nt36523.c, panel-himax-hx83121a.c.
> 
> with this implementation ,I will remove the backlight from the dt-bindings.

Much easier. Call drm_panel_of_backlight() and if there is no error and
panel->backlight is still NULL, then create your own backlight device.

> 
> Please let me know,if I am missing something.
> 
> Thanks,
> Arpit
> 
> 

-- 
With best wishes
Dmitry
