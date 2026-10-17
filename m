Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2272DCCF2C9
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1563010E289;
	Sat, 17 Oct 2026 21:51:25 +0000 (UTC)
Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6424710E289
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 21:51:18 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=8AhvBjG7HuXqA4N9ExrRQYOsSpS2IM4/UU/7cUM6Thw=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792273877; v=1; x=1792878677;
 b=u52TLMY9AOh4q1pD8o6hKpo18LXx8su7DuzCH9ti6s0pvC2sxFA7P4rf6YZxFChhE9GaiRbQ
 kfuNfzBSHTMxPdZy5ojEU77z9Xq0Ymtu+bCId3m11Kp1YgrjqMRk4LhsGpnRjQMrsyYWnP+3Mhv
 r68UwQqHHPfKwOFvf6feMEuZG6Rj0AmasWB2pqH5PVOF5zp6FBHYJZtFVG6lt0nbJHYu2sBcBdT
 oGYk/zTzOg+iPIm5nPzv1K7oZ9pMlgLCTtr3rKki13TbuGmhoszZ4xo/JbiwVFjpYHHgHvIyLMM
 gaIWtVZIU+t47EcxDKdDza22xBj6BBoCtjkN+wZ1M/+Xg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c017e02178789539;
 Sat, 17 Oct 2026 21:51:16 +0000
X-Mizu-Trace-ID: c017e02178789539
X-Migadu-Flow: FLOW_OUT
Message-ID: <ce5a17da-7202-4903-8101-97f012a67055@packett.cool>
Date: Sat, 17 Oct 2026 18:51:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/5] drm/msm: Attach a driver to GMU
To: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com>
 <1118d9c2-4efd-48fc-8a3e-c2cc3eddc940@packett.cool>
 <bc2ed82d-0d91-4683-b9ae-cb4299636c2e@oss.qualcomm.com>
 <20261017100324.1104-1-tvlad744@gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261017100324.1104-1-tvlad744@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/17/26 7:03 AM, Vladyslav Tymoshchuk wrote:
> Hi Akhil,
>
> On Sun, 26 Jul 2026 21:35:35 +0530, Akhil P Oommen wrote:
>> I didn't get a chance to revisit this series after my vacation. I am too
>> not aware of any impact outside of those dmesg warnings. Any chance this
>> recent rpmh related fix is helping with the deep sleep instead of this
>> series:
>>
>> https://lore.kernel.org/lkml/20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com/

Update: the "deep" suspend bounce back was a red herring, it's actually 
related to EL2 timer nonsense btw.

In terms of actually reaching AOSD/CXSD states though, new community 
research has been happening recently (on hamoa laptops), and some people 
have gotten to CXSD buuuuut, with CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=y 
(aka fw_devlink.sync_state=timeout at cmdline).

It's not good to require timeouts, there should not be any sync_state 
warnings. With QCE solved now in the "Fix crypto self-test failures" 
series, the *only* sync_state timeouts are the GMU (on gcc and gpucc) 
and CoreSight stuff (on qcom_aoss_qmp). These can, and should, be resolved!


Thanks,
~val

