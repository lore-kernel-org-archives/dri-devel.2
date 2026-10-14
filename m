Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DABCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F5F112179;
	Thu, 15 Oct 2026 07:57:02 +0000 (UTC)
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4B510E2F0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:06:40 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4fb64d2so1741944a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976000; x=1792580800; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
 b=MDO7uhCydGKYF7F3itCr3b6vQOFQIUBFhqaGhgs0uTfxAswZjzi3EVGmAk+9EwMPh2
 FDTeWnADuOAKD+zw0nvZ7FmXXW42ygvLEcBFECF0YFvXobnAwjiWtwlblwClZKiw0ZfE
 YftXT9fNwlrhGtghOkZJSRqvBzOPEW8UBNBVUxojT6ZBAN+KtbrmB4gqtBQyl7SUSgA7
 6rRZ3CDUaedyfgVVWaW9XquM0fNi0M41h/PLbWz3To1e5R3Ur+wmqdT/wn1JqZkTOUKi
 2Xbdlyz4tIKXBpR1Xy6guFSkKEoyx6o/2db96phpEMh2yzzdsLDtlMAPmXMXs8tej8Q9
 +4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976000; x=1792580800;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E41qJNRzVmPfHenlZSA2Vl9639pSTN9ZvaDbaLPA2p0=;
 b=XOVfEQOtqVlPwEdFlncVy3XX6Z6J++fIh745HlCDe/gkvKAUNi+3OV8JwWTT2tIUG0
 c74StEf9MyQh+nkuZOlG2Lm87vfzec8nlEnS0FECAlZ4DwExrPDDBRuHz8J1aEgOst+3
 +QZcr4NSwcWCXJV0LMoiuh6SqmjieYbw2tgPEfAWhGVaWcZWrScXAx0E2tw4ElSKbnni
 P4/5UHitIObQXPAgIWtr1VYN9iJNbffRPFVb9PP1ewEK2qqm/P6/gPNvbRGcxJnr/fay
 FB/37CgY8CnM7aSDtzhTPnfO3bFn9nw4R1Ft/8CUT9mj941cZNfzXFlG8GTC/xm5W1Sj
 B/Jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzzb2dGHVh3h179KTCW1oKF9Rktd/sz+enZdYWWkDTjn6D1nX4BQN7Ht+hZ1+tIjmTQKq9WCgqBgY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLx/mtaE2HkL5vZV7mSX/cv+xXh7UpX2Pio9CkPP86l2NOdJvB3
 ZkI5Nx8ZK6UU9Vw7O5YYZSGifKQ9hVVhPkYCwlXJYQueqB0FJWaEjVp1
X-Gm-Gg: AYBFou1pSdRplo7GS66rqXAtsiPBejST7snPttNAVoo2MbGMcMOgIEwwOwtME+yFl2/
 kV4u67pqpcQlsK8DkLnHiMJFae5BnExiqrc7UdEkxw3niK6RHha3syIn+CjHT/zU0w5HForSdGi
 FZuYhh1iVNLzKboAFl6oCDDrzHCEkqtvxHtzvnXoj9J5HDcoHv3nnSNk6X7sYzMpiPVkMYEOVS/
 w9xSJqFwW0kN0ORkmdPL9puiDUAY4ia8ikOoAS/8X8E/7eHcxSmis+7eh6fFau7mhnG71ZbR/6X
 W0P5CluJ7ivUo3v/iOLconuvQ9leIiARbqnVEXsq1aOlgl1NyGTGPEC/0RRCTRFRcxXg57E3hqx
 V+8tUbAqALr3SroDpPE2rW13Gje/6aYSWqvsFHaM2rZ+viTaLs6Fjao24vWx4LXdgFGOSogjMDv
 +UfUp5s+Klgfu1xcve05u/mUky/qGQVxAJx2I3dy3/WwGp1e+Si37Ks99ETQNQZCPGiVbeM6r/J
 W20ubEb4srWkyGNrAGcPP03RXOXzHY=
X-Received: by 2002:a17:90b:4a08:b0:3ac:4e91:bff7 with SMTP id
 98e67ed59e1d1-3ac4e91c1b6mr2825151a91.48.1791975999552; 
 Wed, 14 Oct 2026 04:06:39 -0700 (PDT)
Received: from [172.20.10.4] ([240e:471:300:dde:5eec:32d6:f33:1d4b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd5e2b79df5sm5281837a12.19.2026.10.14.04.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:06:38 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
From: Aveline Noir <jm5905938@gmail.com>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 bigeasy@linutronix.de, linux-rt-devel@lists.linux.dev, deller@gmx.de, 
 simona@ffwll.ch, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Date: Wed, 14 Oct 2026 19:06:31 +0800
Message-Id: <179197599193.532954.6543599494592547892.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791975994; l=2119;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=Q4sS6ysJkh6bVqmDm0t8nwutvdPtgGri+t2E+qvwZrQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJSB+KMp1PvZyKEm4roi9iB1DW2hPjN7sh98ZjltMhWCFYkG+UkBAjTEszr3F5A7A+M39+3Sa31
 Dwagjpf+n0w0=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Hi Jiri, Benjamin,

Just a quick ping on this v2 series. Have you had a chance to take a look?

Both fixes have been tested with QEMU/UHID, though not on physical hardware. I'd appreciate any feedback and would be happy to make changes or run additional tests if needed.

Thanks,
Aveline

On 2026-09-28 18:15 +0200, Aveline Noir wrote:
> This series fixes two PicoLCD locking problems. The first moves output
> requests into sleepable context and serializes LED state updates. The
> second breaks the last-close/deferred-worker lock dependency using a
> private framebuffer update mutex.
> 
> The first patch was tested separately with the original syzkaller C
> reproducer and bounded concurrent sysfs/UHID-destroy workloads on
> PREEMPT_RT. The complete series additionally passed repeated framebuffer
> open/write/close and persistent-open framebuffer tests. Pre-fix modules
> reproduced the respective failures. Physical hardware, prolonged stress
> and suspend/resume have not been tested.
> 
> Patch 2's Fixes tag identifies the fbdev change that began draining
> deferred work from fb_release() while holding info->lock. Patch 1's Fixes
> tag was checked against the upstream transport-conversion diff.
> 
> Changes in v2:
> - Address Sebastian Andrzej Siewior's feedback: clarify that the issue
>   is not specific to PREEMPT_RT and identify picolcd_data::lock as a
>   spinlock_t in patch 1. The code changes are identical to v1.
> 
> Aveline Noir (2):
>   HID: picolcd: Move output requests out of spinlocked sections
>   HID: picolcd: Avoid framebuffer last-close deadlock
> 
>  drivers/hid/hid-picolcd.h           |  4 +++
>  drivers/hid/hid-picolcd_backlight.c |  7 ++--
>  drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
>  drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
>  drivers/hid/hid-picolcd_lcd.c       |  7 ++--
>  drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
>  6 files changed, 93 insertions(+), 58 deletions(-)
> 
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.55.0
> 


