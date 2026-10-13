Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A7CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B9C10F9E7;
	Tue, 13 Oct 2026 21:24:56 +0000 (UTC)
X-Greylist: delayed 373 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 21:24:50 UTC
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D67910F9E7
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lucaweiss.eu; s=s1;
 t=1791926315; bh=nKDrPdtKkv5zqB66996w81/rOjJtFS71nRCLGtuyIJ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=wr1S/Hvg5UXnBzW08p4gPWHuR5AUhaU8qt4o5jIMTKUj+OeKC+hNv93KH3yAvxDpT
 bWSf/OAlI7YyJk65IcIwrBW0JqyDSnoTqzp3ZhjWda8U9ksXiLe8wAvyVGfQ/R7T4g
 RTRlh/TI7DeRsVXgSYU+OT8rmt8J0LNvkvc8ugV8=
Message-ID: <6956afb7-9344-4979-bdf0-2584e890fb22@lucaweiss.eu>
Date: Tue, 13 Oct 2026 23:18:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Jasper Korten <jja2000@gmail.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-1-7188e7ea7a15@fairphone.com>
 <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
From: Luca Weiss <luca@lucaweiss.eu>
In-Reply-To: <CAD=FV=WVAnohGm8kmaLpfchk_MxCiUB8EcyyWBxZqtnc+9YPcg@mail.gmail.com>
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

On 13-10-2026 22:35, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 12, 2026 at 11:11 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> From: Jasper Korten <jja2000@gmail.com>
>>
>> Add an entry for the B140HAN04.0 eDP panel. It is found on the Samsung
>> Galaxy Book2 Go.
>>
>> $ edid-decode /sys/class/drm/card0-eDP-1/edid
>>
>> 00 ff ff ff ff ff ff 00 06 af a9 65 00 00 00 00
>> 28 20 01 04 a5 1f 11 78 02 9b 85 92 56 59 90 29
>> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
>> 01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
>> 3e 00 35 ae 10 00 00 18 00 00 00 0f 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
>> 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
>> 00 42 31 34 30 48 41 4e 30 34 2e 30 20 0a 00 ed
>>
>> Signed-off-by: Jasper Korten <jja2000@gmail.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/gpu/drm/panel/panel-edp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
>> index 2b455369ed70..73cdc2d37ab7 100644
>> --- a/drivers/gpu/drm/panel/panel-edp.c
>> +++ b/drivers/gpu/drm/panel/panel-edp.c
>> @@ -1986,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] = {
>>          EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
>>          EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
>>          EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140HAN06.4"),
>> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x65a9, &delay_200_500_e50, "B140HAN04.0"),
> 
> I'd assume you don't have a datasheet here and that the timings are a
> bit of a guess. It's nice if you put that in the commit message, but I
> won't block it. Ideally you could reply here and let me know if you
> referred to a datasheet or just made a guess about the timings so if
> the question ever comes up later we can find the conversation based on
> the Link: tag...

I assume this is just based on copy-paste from the lines around this. 
Jasper made this patch, but I assume he doesn't have any docs like that.

I briefly searched for the panel identifier some days ago and didn't 
directly stumble upon a datasheet.

Regards
Luca

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Pushed to drm-misc-next:
> 
> [1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
>        commit: 9125232bc2a5020710db1eadd21973757f740648

