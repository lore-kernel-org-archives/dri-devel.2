Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFB8C88E50
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4879F10E5A8;
	Sat, 12 Sep 2026 01:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="UNQLGUuc";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Sat, 12 Sep 2026 01:06:58 UTC
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B4A10E5A8
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:06:57 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=jk8Y1OKbEqWlj0AgT45RSv9xPVBl7UcHySE9J9nq9+0=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789175216; v=1; x=1789780016;
 b=UNQLGUucd1R+7rS3h77ES8oEQGO3WFgQzLYZYL3spNOl+D872m8H0uw8n1YilmafL3K+7q9p
 jkKvPcwSTyFL4W+7VKOh/9YQeAKxZSV8kkKEP4MazuZzYRl3Lds3Pf4elhgdssHRGxNQgAIoe7q
 yUoPFRyixJod8hwfeVxOQbytNyXbMI0NKx14gVBUpzfHMxB5CN3BIztnIL1172aHqq2LfphUqZC
 qAqBp0RcmeJHqsxluYGhAH4ScSVpTZBAYvwxmAg+LN6+OL3sSDeabfgdsyaSp4YD2Hm9Osrq39e
 LbPAhOgOEcIn2PkVrEYypNc0yOadELafqRmt3oSwLKGlQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 77080e2825881367;
 Sat, 12 Sep 2026 01:00:41 +0000
X-Mizu-Trace-ID: 77080e2825881367
X-Migadu-Flow: FLOW_OUT
Message-ID: <0049ee8a-d9b2-4692-9494-5a8f054accaa@packett.cool>
Date: Fri, 11 Sep 2026 22:00:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Dell Inspiron 7441 AUO0BA4 panel backlight: PWM
 configuration
To: Avalon Vargas Centeno <avalon.vargas.centeno@est.una.ac.cr>,
 linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 bryan.odonoghue@linaro.org
References: <CAGXpr54Bn9Wf24asY2RcXgBNLy1A16=U1mtFx7mKeNK4CCOCYQ@mail.gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <CAGXpr54Bn9Wf24asY2RcXgBNLy1A16=U1mtFx7mKeNK4CCOCYQ@mail.gmail.com>
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


On 9/11/26 7:11 PM, Avalon Vargas Centeno wrote:
> Hello,
>
> On my Dell Inspiron 14 Plus 7441 (BIOS 2.16.0, aarch64 Linux 7.2.4,
> NixOS), the AUO B140QAX01.H / AUO0BA4 panel originally exposed an unusable
> dp_aux_backlight with max_brightness 0. GNOME could not adjust brightness.
>
> Panel DPCD bytes at 0x700-0x72f:
>
>    05 9b 91 00 00 00 00 00 00 00 00 00 00 00 00 00
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    00 00 02 00 0a 04 0a 00 1b 00 0d 2f 03 ff ff 03
>
> The capability bits indicate PWM brightness setting rather than AUX
> brightness setting. Inspection of the local panel-edp and DP helper code
> suggests that this capability combination can leave the AUX backlight
> maximum at zero. This is a code-path inference, not a separately verified
> generic DRM driver bug.
> [..]

Weird. I know someone who has a B140QAX01.H in a 7445 (that's how I've 
added it to edp_panels) and they did not have that problem, aux 
backlight worked fine…

panel-edp does not seem to care about DPCD indicating PWM; if the 
brightness property is present in the device tree it *will* be used, and 
AUX is used as a fallback if the external DT-provided brightness was 
absent. If we really need to support this (without adding more 
devicetrees), I guess we could add some opt-in prefer-aux-brightness 
thing..

~val

