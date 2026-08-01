Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596D2C55173
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 14:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7157210E2D6;
	Sat,  1 Aug 2026 14:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B+G+ZdWX";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3685E10E2D6
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 14:40:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495502852d1so717095e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785595242; x=1786200042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9wyL+d+FkZCpC7UCAmaMDlbbmuXJOkXNY4cAUr9rC18=;
 b=B+G+ZdWXjH+LfRjHiRhqY6fW/GMtzpdS9ieao+QfQwznN+Ggfgi1D4L7cnMr/gING/
 8zYoBjDC6juu5MIlDtpzm4fRY299vRrY2h88AE5IKSnIMAtFyfK6nS6RWl7dkXpXF27e
 rKdjmqu29FqecY8XDwvrUAvlOJnLlUqTiwD3eJDbgJfUORY0GFdvR4mQDTJl53aPyeHi
 WRtMKWzPSMlEID4p5F9uOKQXsXMKAoMN5JNjyXsqmwBorX4EinLfT+Oq/RK2V17mDk6w
 CbECSBOHoBEUNjVzwsY0Ind+uHxvn3qjxOqC01DK5SFKiEDjjFDhaIwBG2JvunSoxzSP
 LBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785595242; x=1786200042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9wyL+d+FkZCpC7UCAmaMDlbbmuXJOkXNY4cAUr9rC18=;
 b=ca3Bz8pKQGaKYyNng7BjtasmO1XLuQEoJ8Dv45LHNN9mU/0lKO/BpsNnis5ShP+JeZ
 BTeZQAKADirHukWeAiO5QUYtJyhD2+HREimkNu/XmKHJISwh+6G57iB8h1rEGwb72lUY
 YoE+iE3V8XpxqgQ1e8fJgEV5Ve4aRjZsshiDg7Hc+e3t464mEv7NPG2eDklsyu9EgShW
 tvpxCmneHnUJ03e4e+yL6ZFFvrVxojFRAJZIJ7ZOCM07B+fN7zAc5uNO2xW0MgRaZXmr
 25LJzNMdIDA55a3EL32WRsMym9V9/yICa0lxyrXSlW8sgcgPxVM5TUNHY2QEuBJkSAwv
 mZ/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqt5oi6kikaVA4KoxaLeNOvRpsjB/U1E8Qg01GpylQ3JarqP+sj7dKDmtmHup+AIfzeN8OVpxefFFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9kkPsVe6RskwqUKkr62CFqgaCNQRNQVR3+yoRjG0eaqBiKuAz
 NNmRzyBTLuvSm9B2DS/UiPpc+Qs2q717zJ1MvYzz30glAhTxWg46b5td
X-Gm-Gg: AR+sD11JM0aACq4vkQE6J4ocH5CMmjk9ZIqM/XHWVKrGlll+EpY9rr2RePbsDUnnR1u
 1CPOMAY12vWXHRvjOgNfuw/eeAwboH45kMsNPrAETTb94u4py5Y2o247IOlGtrd2I2m0SAyFLbX
 AP7NvG+RdFZ3YJo04zHQUC/OqGiDBu4pjs9ePVE07q+Oy1tI9CWR32qUgOsBWFnp2J20CHH1Dw7
 o9aNA/i/Zx6ILTkTD2pY4/DaEodqrZRxTBKYXnHzjYCLYtbJakUGcLAbt2VpZ/cmzMHGVAHBjSE
 616FM6KPNPeVXIwJ8p2XLYzk7GtLNXpQPC7LdgHu96mQOshrDsKPTlvC4e3pTYTfyHAVcepaThL
 JB1eJTMCJ4n1NgyxWiXbUenL8wrae2AvtRzPSyuEXROwVLXVKpQLZMrOJdGUfkgiCDd1HHH+FsD
 Bi68oobsJn8khM8QDfYik9TLPGJ4JY7dWkJs4FwdEuYYza50tuYgf0t6F58zrxMFstpczbluDce
 t16yEjl381Zor5QjOVSP2TicWl3VB8IawBwwk3ZG1EWKQ5ezj/1v78qMGA4AQa+KprerVTKp11e
 M9E=
X-Received: by 2002:a05:600c:3b20:b0:495:3eb4:3c6d with SMTP id
 5b1f17b1804b1-4980c69d93cmr29227955e9.2.1785595242332; 
 Sat, 01 Aug 2026 07:40:42 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B870700763FC51387692655.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:700:763f:c513:8769:2655])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b5f0adsm59197585e9.4.2026.08.01.07.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 07:40:41 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Sat,  1 Aug 2026 16:40:21 +0200
Message-ID: <20260801144021.7583-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DKDOBW9CJ2Y3.10EEIZDTXPYJZ@cknow-tech.com>
References: <DKDOBW9CJ2Y3.10EEIZDTXPYJZ@cknow-tech.com>
MIME-Version: 1.0
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

Hi Diederik,

(re-adding the lists, your reply came to me only)

Thanks - that pointer was useful, and it changes what I thought I was
looking at.  Two things came out of following it.

First, a data point that may narrow your search rather than widen it:
this board is not running upstream TF-A.  Its SCMI implementation
identifies itself as Rockchip's own:

  arm-scmi arm-scmi.0.auto: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0

and it still fails, so whatever this is, it is not exclusive to upstream
TF-A BL31.  If rkbin BL31 makes your PineTab2 suspend/resume work, the
difference there may be something more specific than the ack handshake
itself.

Second, going through the archive for that error string, the history is
longer than I realised - Peter Geis' and Sebastian Reichel's pmdomain
work on RK3588, and further back "arm64: dts: rockchip: add hevc power
domain clock to rk3328".  That last one is interesting because the fix
was to add a missing clock to the power domain, i.e. the handshake
needs its clocks.

What I have looks like a neighbouring case rather than the same one.
Here the clocks are not missing - all three NPU domains already list the
NPU clock (rk3588-base.dtsi lines 864, 877 and 885).  It is the rate
that matters: the ack never arrives if the domain is moved while that
clock is above its DT assigned-clock-rate, and the same domain moves
cleanly once the rate is back down.  I have not seen that variant
described anywhere, which is why I wrote it up.

That suggests something you could try, though it is a guess and you know
your board far better than I do: if any clock listed in a domain you are
suspending happens to be at a non-boot rate at that moment - left there
by devfreq, by an assigned-clock-rate, or by whatever ran last - then it
would be the same shape as what I am seeing.  Pinning those clocks to
their boot rates before the transition would be a cheap thing to rule
out.  If it does nothing, at least it is eliminated.

Thanks again for taking the time, and good luck with the PineTab2.

Igor
