Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBBC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233D910F8EB;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWkewzZC";
	dkim-atps=neutral
Received: from mail-dl2-f22.google.com (mail-dl2-f22.google.com
 [74.125.229.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C6710F78E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:05:14 +0000 (UTC)
Received: by mail-dl2-f22.google.com with SMTP id
 a92af1059eb24-14383fddae4so219716c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790283914; x=1790888714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1NmZmhgLOy/YmQC3GmGsf1VOw7I8/+ySPDXRuFIlrI8=;
 b=QWkewzZCsM1B0X4ITFkRYAO0dfNWysEX/cxDNn2oREpKquzfdtIYVjxBlyePn4e9ky
 P8y2d+mB4Hx9JApWK27xGYSS/oVa2mqNj0jS6kDtkqO6zYVvTImJeCZ5oOP1EYTVIYd1
 6aGoPRNv2GFAYI+XZyofl/GWnk7aPqoRIgvyvvxG2bpoOKD8mBnEowLpgRPFSuMLFyED
 S5eFKdBaQIi/1XUkBF30PlhwnMrVIguJ9am06UvGAnbV4YViYaLJ0DLJAOpM09ekHnUs
 kaxOkgN4Bm3nWro//CPqTdoI05MuED34ZjF4HdHb5BZweW1llKJFjrzsmB6aoa08RjWH
 eHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790283914; x=1790888714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1NmZmhgLOy/YmQC3GmGsf1VOw7I8/+ySPDXRuFIlrI8=;
 b=01whG0bqwKLoEYKS/Is71b0ZzaM/YsQgv0Ld2MZKs6mD3Nrp1vtqVvj8Q3KTsnw98e
 +sc2t1+mpKqFR8nppXu4e+eFeiS7TgfUlVErt0AfNl8AV2OdNx2vvZm3Db1MM3Y6mTSA
 aoMppb/F6TXX3MHaBA9W4fnjKzW/yqLt/8G9JvoJ/qzLae8bUs48vd7cawGbWVpqNCFG
 YY3pbYSg+BBfAquNa00N/O8ddKSpbphRO6X+zpiiwLAzOr1Esu/rQ7GNQ9sh8Jg1Ao4h
 dVlaUI05WzjGlGadMS7KqbbQcCUGqnFCMQ2s7D9GOD013OPntjbRgu9Itv4pIUZsVG9L
 b1zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzegHkGoL2IAgzMkg5b7u4TaGgOhc+JDJH7pZj7GoEIEl421iwadz6ExtrhQG2G9F2Y0FE2wP7H3xw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRMT8FDNkwlppAdFxH8bcUy7IYqybiU7XhBEM+/PVBTYbAQDQJ
 RX47VYbtTmy3eltZWjsxxSq3/+kRPAp6AROLGinKEnu0e2QCpkC3Zbx1
X-Gm-Gg: AYBFou0eDKXxaFB7LYEG+B5n515r8wzw9xtiE/k3bEWae7TO3XgARl8xkY51DWnpI7W
 uwvoVVgka0Qu4Q8Yrq1HUNqHSqzViWSIaL1xWEP3KuiowxcJoOqvMJn2RBCGcsVfhAXzHPr3SB9
 oAfUpkRZnfG05kzGU2m0QAJasGAw241Q7oJXtUYCrZL1AOMEI1Rv7mpZWlEDYYgC3zxbCucUQu/
 Xlw0XBEtPBmA426b2vdnA4hqNDd4qKDFSOq+jV+/epE3kEBqSQ6Ptn0+SsVo6H4e6ofzt9Osmqx
 YrUcX3GIPJZgSUZE/Fe11UPh6A5zMZZoFD7PMVSnQHFzQwtLL9WOTAmuFm7Hxjss8dzxb8USH6g
 glVuntQk2Cbgdo/Vr82Ixr1OmNl/HVe2b8anvCIuCUurkr41fka1e4wIEa+ECbf/OfqsVL9RoxG
 T9On5jvtcBg7RTBztWxt+Bw018lkhFwPsbyMmm+HELJ39ivTEijrqUxF+cK7Yyy6WBs4MeMYGg3
 VuO5SAQ7WBJbuV4cGE=
X-Received: by 2002:a05:7022:fd09:b0:13d:974:a42d with SMTP id
 a92af1059eb24-14503fde9d8mr4585588c88.22.1790283913457; 
 Thu, 24 Sep 2026 14:05:13 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c0ccsm1054300c88.4.2026.09.24.14.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:05:13 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/gmc_v8_0: restore the FB location after a
 re-POST
Date: Thu, 24 Sep 2026 18:04:57 -0300
Message-ID: <20260924210457.13100-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
References: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On Thu, Sep 24, 2026 at 11:21 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Thu, Sep 24, 2026 at 11:06 AM Christian König
> <christian.koenig@amd.com> wrote:
>> On 9/24/26 15:29, Francisco Beltrán Millalén wrote:
>>>   cold boot:   MC_VM_FB_LOCATION = 0x007f0000
>>>   after reset: MC_VM_FB_LOCATION = 0xf47ff400
>>
>> Mhm, interesting I'm really wondering where those values come from.

0x007f0000 is what amdgpu finds when it loads after a cold boot, with
HDP_NONSURFACE_BASE = 0: the framebuffer at MC address 0.  That is what
the platform hands over; I have no trace of who writes it before the
kernel runs, so I can only say it comes from the Apple side.

0xf47ff400, with HDP_NONSURFACE_BASE = 0xf4000000, is written by the
VBIOS ASIC_Init table that amdgpu runs on resume and after a GPU reset.
I traced the register writes across that call.  As far as I know it
is the usual 0xF4_0000_0000 placement of Polaris boards elsewhere.
(The "0xf400_0000" in my commit message was wrong: the MC address is
0xF4_0000_0000.)

>> I think the more defensive approach is to do an ASIC reset on driver
>> load and use the values the AtomBIOS init function comes up with.
[...]
> I agree that running asic_init
> on boot for Macs would make sense.  I think we already have a similar
> workaround for some other mac models, probably to work around a
> similar issue:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5be7ad8f5f0e067613e9197638f216f46252946
> Maybe add your device to that existing quirk or make the quirk generic
> for all VI boards with apple ssids?

That works, thank you both.  I backported a5be7ad8f5f0 to 6.18.49,
added this board (106b:017a rev c7) and dropped my gmc_v8_0 patch:

- On load: "PCI CONFIG reset", "GPU posting now...", then
  "VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF", after both a
  cold and a warm boot.  With a debug print just before the reset,
  MC_VM_FB_LOCATION reads 0x007f0000 before it and 0xf47ff400 after.

- S3: 9 suspend/resume cycles (lid close and rtcwake, one of them with
  the lid closed for about 7.5 minutes and a USB-C disk attached), each
  followed by a few minutes of 3D load.  MC_VM_FB_LOCATION stays at
  0xf47ff400 and no ring timeouts or VM faults were reported.  In 4 of
  them my old patch was still in as a detector and never fired; the
  other 5 ran without it.  The kernel also carries my unrelated PCI and
  ACPI patches for this machine.

- Cost: the reset and post take 20-35 ms, and amdgpu init up to fbdev
  takes about 0.23 s longer than before.

So please consider the gmc_v8_0 patch withdrawn.  I'll send the one-line
quirk as v2 in reply to this thread.

Two things in case you prefer the generic version:

- The GPU here is a Radeon Pro 555 (2 GB), not the 560 I wrote.  The
  MacBookPro14,3 was also sold with a Pro 560.  pci.ids lists 106b:0179
  as a Radeon Pro 560 and 106b:0160, 0166 and 0167 as the Pro 460, 455
  and 450 (the GPUs of the 2016 MacBookPro13,3), all 1002:67ef.  I have
  not checked those IDs on real machines, and I only have this one, so
  I only added 017a/c7.

- From reading the code, on VI the reset on load is always a PCI
  config reset: the BACO capability is only known once the PowerPlay
  table is parsed in hw_init, after the reset.  That is also what
  happens here.

Thanks,
Francisco
