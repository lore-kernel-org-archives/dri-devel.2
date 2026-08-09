Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112DC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 07:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441EB10E0E4;
	Sun,  9 Aug 2026 07:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="d9CB4Ayp";
	dkim-atps=neutral
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Sun, 09 Aug 2026 07:33:56 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FEB10E0E4;
 Sun,  9 Aug 2026 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oldschoolsolutions.biz; s=s1-ionos; t=1786260834; x=1786865634;
 i=jens.glathe@oldschoolsolutions.biz;
 bh=b13z1BQp+A4wvohJY6qb+Vk7IxT1A2JtapJ7LUSfiXs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=d9CB4AypEnG1wn4awXNfk7Ecw11J0+WGGNulMX8+LdzG/Paq4/O/vIrtZEQ3aL2F
 xKOnzdFRnXJF+CuiJD01O91FHIm3RPAKotqh/Cb1OJW4yciPDbSOBSl9N6NIWODvJ
 lN7QLPeH1Q4kyp/BewjvejHKlnolWCbRqLBqxeSCigs2hhVdNiX3p6hXDL7km55EQ
 7Z1oQdOHl1H+J2as6n4HqS8EJrJl5jpTgq7bm+onl4mhMqWbPTrTmRpWZ39qL0g/v
 ktRFG9nG9c6/FQnAHZHCLpUfxggRzJ9m2JEmPuQwYHJlsqk6jy61/N0t9PAR3zlun
 xsWRApmo6NaZGZEDpg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mt6wz-1x8q6i3nPF-00xMo1; Sun, 09
 Aug 2026 09:28:10 +0200
Message-ID: <ae78a94b-4feb-4ef0-8f1a-71786a101ed7@oldschoolsolutions.biz>
Date: Sun, 9 Aug 2026 09:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] driver core: platform: / drm/msm: dp: Delay applying
 clock defaults
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, Michael Walle <mwalle@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Val Packett <val@packett.cool>
References: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2BjJNVrz4XFnwJd/V7HuJABJZBpMXLf+6xBaN1lUxPDyi34rF2Q
 4shHNOqea7V5mBPoxmM9tUSlohrKQgZtZ1JjIJ8xy1XShVkQOx4cuIsqIfbbUefWdWTcWLp
 Iy8aaK44NRpsbbX94f4gFjnsCYv+weFLnuicNBdDNO6yJTPEoIJkFRHej3MUdg0rF95Xavk
 3OPHFKXwbvK8zYbRCqeag==
UI-OutboundReport: notjunk:1;M01:P0:APdvwCEtwJg=;Gf9uOs0e9Xt3U9yhI1BCruR+uky
 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
 =
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

Hi there,

On 14.08.25 11:18, Stephan Gerhold wrote:
> Currently, the platform driver core always calls of_clk_set_defaults()
> before calling the driver probe() function. This will apply any
> "assigned-clock-parents" and "assigned-clock-rates" specified in the dev=
ice
> tree. However, in some situations, these defaults cannot be safely appli=
ed
> before the driver has performed some early initialization. Otherwise, th=
e
> clock operations might fail or the device could malfunction.
>
> This is the case for the DP/DSI controller on some Qualcomm platforms. W=
e
> use assigned-clock-parents there to bind the DP/DSI link clocks to the P=
HY,
> but this fails if the PHY is not already powered on. We often bypass thi=
s
> problem because the boot firmware already sets up the correct clock pare=
nt,
> but this is not always the case.

I have this case on the Lenovo Ideapad Slim5x 14Q8X9, on the HDMI port.=20
when booted without an active HDMI connected device and hotplugged=20
later, it produces these errors (and no display):


[=C2=A0 552.501910] [drm:dpu_encoder_phys_vid_wait_for_commit_done:545] [d=
pu=20
error]vblank timeout: 2021300
[=C2=A0 552.501927] [drm:dpu_kms_wait_for_commit_done:527] [dpu error]wait=
=20
for commit done returned -110
[=C2=A0 552.540863] [drm:dpu_encoder_frame_done_timeout:2731] [dpu=20
error]enc40 frame done timeout

When cold-plugged this works, and can be hot-plugged later.

Further investigation showed that the main link clock doesn't come up=20
regardless of what is done, unless it was initialized by the boot=20
firmware before. Applying this series (found by Val, thanks again)=20
solved this issue.

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

> [...]

with best regards

Jens

