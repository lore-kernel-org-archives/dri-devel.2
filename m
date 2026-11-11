Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22387606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTfuEdgL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C4410E397;
	Wed, 11 Nov 2026 09:56:17 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E34210E397
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:56:11 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-33c10faf6easo46493eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794390970; x=1794995770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=etMBeFFvTZ16JTCJaXFRCqu9zDzZcOqbu475oSnC7og=;
 b=XTfuEdgLwJnt08GWxFGs6pquV3lMW6I8QY6FDM81rnGIrDDTzvAjJDmEL1FC9rjAEi
 kKTGsrQ0ND9Z8mL5M2psfVWAJ2HENB+D3tJepvJjDvLqY24DC8wVRrfGTRi7bjC8QwEb
 vdpDdA7+2GDZmHkAoNihN7EFfGFh+ygYLvMEeL1G9LdiODJicTCM9KvOlrkLsNCAcCpn
 9sTfZA7NDBlZz0nhiPbtGVb5ejP6yeMuKZj0fIEBHtn4TGHjXr2Dus/Az1asqOXUKikf
 LxGckMuDQi0Gma1b3kKVFRHaQ6Fm1Zl7PqJ/xZgZYtUF3GZ6VgeETTP6AoM089aipBvw
 g8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794390970; x=1794995770;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etMBeFFvTZ16JTCJaXFRCqu9zDzZcOqbu475oSnC7og=;
 b=ljb/Hs1CXji3spW5gc1fdWXwz+fISYg4jPyQbVB1/Dotc4tp6pLk7H0tBoFjeeZ67e
 zgBaTEVjl3oBZzZCvsy+S+budDMUQRPCWZn7xQRqEexMjG0mTN8FX2pMcczDJ2JTQ+vk
 K0fBxoHXPo4/tYUf7TYWHYQDF57P/5jwuk52vPVEzTmzz9cErI5MfZAUEISl3lRBdhVA
 OvIfITgpx5Zcl7CFubFC8AfHhtL/DU6jZ7B74EPoMfYBwydg0FRM+PbUVn/a5/pgjB31
 vzuwBlv1Xndxrs4NFehZrXn378Z0ljziivdA5DtkCGZQPAvAokGcX6K4cz8H3KFKSo5d
 nNng==
X-Forwarded-Encrypted: i=1;
 AL+hErGoOyaRA4cQeRNe6+oIliteZJYBKNeqnZC6lP6psXR9zU4s1wQrQ2NWq1rlJuCgt5W249y0huRjLv4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wV+ZjvS9iBh/OqzQAjm1gcjRzY3wrV6M3VgW8ZByA+sSpGwin
 jT7kLBKkEVL903swVx928fRjpv5GrLsaXG/qmBcR9fznUZwjQJZFN3mV
X-Gm-Gg: AYBFou2EhFFRZsLKsaElhJLtSEvs2+GoYyJaab+T0HlksM8ehuNH+pDl8PG0pwNSHOZ
 x0sZV+EJoGYJHWatDbklXklu5XqqTGtQENUYHgmt5O77jpn3Q+BQROIE5gYbOyzhK1XH+R4ukUg
 4QOrWiFbAYiq7RMXumgfjyPfLldQGiPoxu/sJCVIdz1HC76FT3PBTu6ASM7LEfeP0EQYCniyLFJ
 wPgdJtSo5R8RgU9HZlN2s0qtrGoz2/gIIRocDTkBHVBwv02DMnJ4nBDporYtT6kDTrucBKI9lNY
 9b44b601aIRqWtl33fBn54gEEzWBVkV66HOeaO4+LQRK8r1n1X/6l6OQfmnkkirr7uGjK4qBAlN
 PhabfyiGt3iftaB3FHzcpTCGx0GTjJZzKOIYN9w6RGVnAPTyig7Kvnv6t8MqfUeE24IQV6CRuB4
 nnCbcKOMbxd+4WJ0XWon1YgTeGX52QnbWqkTYUwwvyOZ97eXQqoemcm80chicAZi+EgafIEu2DK
 raEKwvynmJ9yaEKPg1OW23lucwei+XPwlzFJSAl96zBOvwIiNqfr64xz/8Q1Glkv+6oKboA0d2d
 3JbgJX30y8V+hGMTLnEXm07eZf/WLmneSNyTJ1B0mqVyN82uUkgUMV3THE2hGmXk1DUFvqU=
X-Received: by 2002:a05:7300:5621:b0:36d:cd5d:d809 with SMTP id
 5a478bee46e88-37684af683dmr3732846eec.1.1794390970156; 
 Wed, 11 Nov 2026 01:56:10 -0800 (PST)
Received: from [192.168.1.205]
 (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com.
 [2607:8700:5500:a805::2]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bf3e18sm28141912eec.16.2026.11.11.01.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 01:56:09 -0800 (PST)
Message-ID: <72a2f21b-fd6b-427d-afa6-b15dc0729650@gmail.com>
Date: Wed, 11 Nov 2026 17:56:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
To: Tim Surber <me@timsurber.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Maxime Ripard
 <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261110215535.2658927-1-me@timsurber.de>
Content-Language: en-US
From: Frank Zhang <rmxpzlb@gmail.com>
In-Reply-To: <20261110215535.2658927-1-me@timsurber.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 05:55, Tim Surber wrote:
> Hi Frank,
> 
> On Tue, Sep 15, 2026 at 06:34:33PM +0800, Frank Zhang wrote:
>> The crash occurs when HDMI audio callbacks access registers after DRM
>> atomic framework disabled the PHY.
> 
> I reproduced this on a FriendlyElec CM3588 NAS (RK3588) and tested v6.
> The bug can be hit in more situations than the reboot case in the
> commit message. The details are below in case they help with the
> commit message or with the stable backport.
> 
> Setup:
> - rockchip for-next at c3baae5f1 (7.4.0-rc1), arm64 defconfig
> - HDMI TX/RX audio DT enablement for CM3588 on top (HDMI-IN series)
> - Debian forky, GNOME 50 / Mutter 50.5
> - HDMI0 TX looped back into the RK3588 HDMI RX, so playback on HDMI0
>    can be captured on the HDMI-IN card for a functional check
> - netconsole to capture oopses
> 
> Without the patch:
> 
> 1) Display off, then open/close the PCM
> 
>     Mutter switches the outputs off (CRTC fully disabled):
> 
>       busctl --user set-property org.gnome.Mutter.DisplayConfig \
>           /org/gnome/Mutter/DisplayConfig \
>           org.gnome.Mutter.DisplayConfig PowerSaveMode i 3
>       cat /sys/class/drm/card0-HDMI-A-1/enabled   # -> disabled
>       speaker-test -D hw:HDMI0 -c2 -r 48000 -t sine -F S16_LE -l 1
> 
>     hw_params fails with -ENODEV (prepare sees tmds_char_rate == 0).
>     The close that follows still reaches clear_audio_infoframe:
> 
>       Internal error: synchronous external abort: 0000000096000010 [#1] SMP
>       pc : regmap_mmio_read32le+0xc/0x24
>       Call trace:
>        regmap_mmio_read32le+0xc/0x24 (P)
>        _regmap_bus_reg_read+0x68/0xac
>        _regmap_read+0x60/0xd8
>        _regmap_update_bits+0xfc/0x14c
>        regmap_update_bits_base+0x54/0x80
>        dw_hdmi_qp_bridge_clear_audio_infoframe+0x30/0x40 [dw_hdmi_qp]
>        drm_bridge_connector_clear_audio_infoframe+0x20/0x40 [drm_display_helper]
>        clear_infoframe+0x50/0xf4 [drm_display_helper]
>        drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x64/0xcc [drm_display_helper]
>        dw_hdmi_qp_audio_disable+0x1c/0xa4 [dw_hdmi_qp]
>        drm_bridge_connector_audio_shutdown+0x28/0x4c [drm_display_helper]
>        drm_connector_hdmi_audio_shutdown+0x1c/0x30 [drm_display_helper]
>        hdmi_codec_shutdown+0x58/0x7c [snd_soc_hdmi_codec]
>        snd_soc_dai_shutdown+0x54/0x80 [snd_soc_core]
>        soc_pcm_clean.isra.0+0x5c/0x1e0 [snd_soc_core]
>        soc_pcm_close+0x34/0x60 [snd_soc_core]
>        snd_pcm_release_substream.part.0+0x88/0xe0 [snd_pcm]
>        snd_pcm_release+0x58/0xc8 [snd_pcm]
>        __fput+0xd0/0x300
>        ...
>       note: speaker-test[1576] exited with irqs disabled
>       note: speaker-test[1576] exited with preempt_count 1
> 
>     The task dies holding the ASoC PCM mutex. Afterwards the
>     close_delayed_work kworker stays in D state in
>     snd_soc_close_delayed_work(), so audio stays broken until reboot.
>     One of my runs ended in an SError panic instead of the
>     synchronous abort.
> 
> 2) Display turned off while a stream is running (the wider case)
> 
>     Start playback on hw:HDMI0 with the display on, switch the display
>     off through Mutter as above, keep playing, then stop the stream.
>     Playback keeps running normally (state RUNNING, hw_ptr advancing)
>     and nothing is reported to user space. When the stream is closed,
>     the board dies: SSH drops, nothing reaches netconsole, and it
>     reboots only through kernel.panic. I reproduced this twice.
> 
>     No application error is needed for this. Playing audio over HDMI
>     while the desktop blanks the screen, or while the sink is
>     unplugged, and then stopping playback is enough. I suspect this is
>     also what most users hit in practice, more than the reboot path.
> 
> 3) HDMI output never enabled (HDMI1, nothing connected)
> 
>     Opening and closing hw:HDMI1 repeatedly fails with -ENODEV and does
>     not crash. The same holds for WirePlumber probing HDMI0 at boot,
>     before the compositor enables it. The register accesses only fault
>     after the PHY has been initialised once and then disabled, which
>     matches your analysis.
> 
> With v6 applied:
> 
> - Case 1: the open now fails cleanly ("Playback open error: -95,
>    Operation not supported" from the new startup check). No abort,
>    and the system stays healthy.
> - Case 2: playback continues after the display goes off, and the
>    close completes cleanly. No hang.
> - Case 3: unchanged, -ENODEV, no crash.
> - Functional check: after re-enabling the display, a 440 Hz sine played
>    on HDMI0 is captured correctly on the HDMI-IN card through the
>    loopback, so the prepare/infoframe path still works.
> - Stress test: for 2 minutes, HDMI0 was toggled on and off 114 times
>    (atomic commits disabling/enabling the CRTC at random 0.1-0.9 s
>    intervals), racing about 2950 open/play/close cycles on hw:HDMI0
>    with random lifetimes. No oops, no hung tasks, nothing new in
>    dmesg (lockdep was not enabled).
> 
> It may be worth adding the "stream open while the output is disabled"
> case to the commit message. It is much easier to trigger than the
> reboot race and makes a stronger case for the stable backport.
> 
> Tested-by: Tim Surber <me@timsurber.de> # FriendlyElec CM3588 NAS (RK3588)
> 
> Thanks,
> Tim

Hi Tim,

Thank you for the thorough testing and suggestion. I'll update the 
commit message and send a new version as soon as possible.

Best regards,
Frank

