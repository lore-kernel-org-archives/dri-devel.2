Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EECC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C85410E47F;
	Sat,  5 Sep 2026 15:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ferrisoft-com.20251104.gappssmtp.com header.i=@ferrisoft-com.20251104.gappssmtp.com header.b="LX30/FLS";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A13810E181
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 06:54:48 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so287919466b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ferrisoft-com.20251104.gappssmtp.com; s=20251104; t=1788591287; x=1789196087;
 darn=lists.freedesktop.org; 
 h=references:in-reply-to:subject:cc:to:from:message-id:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SlZOwE2gxMp9igH71u8jaG9HaW47C3h9syv0hxH/Boo=;
 b=LX30/FLSY7Kv/hujQzxY/qGTk2q35e+ZE3aH3QSh14btwtZLveWOs0WePkEXyTHNqR
 w0inaBjxQALDfskrUOzvnrTzqlsUSUtwVp6yBRVW1E/9dTFQyLH/FwnBx9MYUhKQTtHX
 J5bSCdOFt6WLNPzWtpX0PLLdFHNlkiK81d1JAstaiTKUqMcstwztFBaYBkfPF/RHzByo
 znOMV10+kV6pbw0BHb/XFcfq3EAhfgOaCtOQKltDnco2thKWjsCd/br+mfP+WztwpOLW
 /4i/IZQ+nUaXAqqJlJPLaATrzMoCMHy10BVr4OyIMYZdxb5FhBpnlhyuEuQ0WnY4NfSi
 6otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788591287; x=1789196087;
 h=references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SlZOwE2gxMp9igH71u8jaG9HaW47C3h9syv0hxH/Boo=;
 b=TpB+xT3FS6H8R5sVRJnKQFTT1GF7Yi3C+yWA6Ci3ewghimAGi3LGRWSSHVQD9e/aqj
 rjhNTBRKn5XUBGa9+l9ZQAq71jPp0MSAollpCAaSADzmEIYdqYAf8lbZi6fYIRxrlMMv
 zgQFIgNOk4lDrGzEa1QCa3e4GyACQbk7CBVALoIS6ia17jqKnVjXI090X2BTXiGjceJj
 01ptNRhJnHJ584RQfK3ui/JzES5O0PdPI2Xh1UieOe9LdH7stzOtHdoKEeyuWQxvcA+w
 5MjHXN6dWPkj7lY3PeHoIrD8lCuFYpQKnZWx1rf8Xqzbr/WDuqNF1G8oB8qTv+ssQIgv
 I0Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBydEPdeVE437M251OGvUDeeUR6D94LVbuxoLIjmb/316LmPI/apuD0RfDZgEZmVQ2JcAWWuTg6TfhE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5gxW0bOi155HQyCUWeTsIA1vBqKZSu+TmNXIAjLB/LFW0mgi7
 2BdfnSZ8MF3uVvTH/+UD518Lsdby89B6zBk/ymsjlnPFRjHY1Zotkq/CIIzjjYp1M79N
X-Gm-Gg: AYBFou2CDzPf6YmFGyY8NU5EUl0AtnBU/Pc6ypzpaLGIVhOf0ChknKvPXutrXE96ZUH
 7YUOWFEWR13WsPQXnVnZL1VIcxl6g1/h8dYa1hje1GqTCAyEEOsrZedK7qrfdShQpdBijApF3u3
 1aEtnVEJFvIXPH1sAd/1ELYGMksX2vAbkrP9Rfc6TvzOvQHYyPa5Rn43vMtHTqlxgEihDjZdfl+
 +RS3DnmWon/pV14ryEQNysSHzx4df6OncP7vAE6PtKlDWSNkYe5ZQVeEbYKYjdmqv94Gn9f1kIi
 zy+NQg65ZVWU30z61VhxVsQ8F2Mfu8lLaMitOgR/nXJI1Z2K3CVvIXc5TZnSi6dqFtqtFg/YHJV
 qsAyYt7I+81mIwKHlQu5Z0FMho7OI0FA+h/dB+snZkZeyilVGMZV0qH1rT39TUra64VLyZxkz6l
 ANDnsxsXu8qvQ9cNykLG9le5B/4NApVH9cKLCQyVvO7Syo1mbQF8hQ4b4JZBZa6R2B7oms3Po7B
 j3bxazOylUEpl3sFzX4jJ33PPRG7A==
X-Received: by 2002:a17:906:7953:b0:c25:f7dc:2d7 with SMTP id
 a640c23a62f3a-c25f7dc09a7mr619235566b.24.1788591286638; 
 Fri, 04 Sep 2026 23:54:46 -0700 (PDT)
Received: from outbox-0008-reply-a8xx.eml (45-11-61-69.ip4.greenlan.pl.
 [45.11.61.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b29f3sm195278966b.52.2026.09.04.23.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 23:54:45 -0700 (PDT)
Date: Sat, 05 Sep 2026 08:54:28 +0200
Message-ID: <20260905085428.reply-a8xx-fmax@ferrisoft.com>
From: Greg Ociepka <greg@ferrisoft.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <rob.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
In-Reply-To: <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
References: <20260820154428.1278@ferrisoft.com>
 <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

On Fri, 4 Sep 2026 04:29:16 +0530, Akhil P Oommen wrote:
> On 8/20/2026 7:14 PM, Greg Ociepka wrote:
[...]
>> We are happy to test patches, run instrumented builds, and provide
>> full journals or devcoredumps - the machine reproduces this every
>> couple of days under normal desktop use.
>
> Does your tree have these fixes:
> https://lore.kernel.org/lkml/06489359-1b96-43ad-a065-bfb9bee51a10@linaro.org/t/#u

Yes, all six of them. I checked each patch of that series against
linux-next (cgit):

  d9108bfdb746 drm/msm/a6xx: Fix stale rpmh votes after suspend
  b303e1d52811 drm/msm: Recover HW before retire hung submit
  fc7ccbc6174b drm/msm/a6xx: Fix A663 GPUCC register list for state capture
  d052d0358fb8 drm/msm/a6xx: Fix A621 GPUCC register list for state capture
  bc024d325e98 drm/msm/a6xx: Fix IRQ storm during msm_recovery test
  40b793714ad8 drm/msm: Fix task_struct reference leak in recover_worker

All of them are already in next-20260730, which is the tree the report
(and the four incidents in it) came from, and they are in
next-20260831 as well, which this machine has been running since the
evening of Sep 3 (7.3.0-rc1-next-20260831, with the same local
platform patches as described in the report, still nothing anywhere
near the GPU, GMU, GDSC or clock paths, plus one unrelated
fs/buffer.c fix).

So the loop reproduced with these fixes in place.

For completeness, the timeline since the report:

- After the report I started running thunderbird, the most frequent
  "offending task" of the earlier incidents, with
  LIBGL_ALWAYS_SOFTWARE=1 (llvmpipe) as a user-space mitigation.
- The last incident on the next-20260730 tree was on Aug 30, 12:10
  CEST: 689 "hangcheck recover" cycles in one boot, with a different
  client as the trigger, so the mitigation did not prevent it.
- Since the switch to next-20260831 on the evening of Sep 3 there has
  been no incident, but against a historical rate of one every few
  days that short a window does not mean anything yet.

> Also, could you try limiting the Fmax to < 1Ghz?

Yes. The OPP table as the kernel sees it here (available_frequencies)
is 310, 410, 572, 760, 820, 915, 1070, 1185, 1350, 1550, 1700 and
1850 MHz, and max_freq is at 1850000000 as I write this, i.e. the
full range. I will cap it at 915 MHz, the highest step below 1 GHz,
through devfreq at runtime:

  echo 915000000 > /sys/class/devfreq/3d00000.gpu/max_freq

and keep the machine at that setting under normal use. It is a sysfs
setting, so there is an uncapped window after every boot until it is
re-applied; I will log that window per boot and check any incident
against it, since onset correlated with session restores in the
earlier incidents. Given the historical rate I would like to give it
at least two weeks before concluding anything, and I will report
either way: at the first incident under the cap (with the journal and
trans_stat, reset when the cap went on, so you can see devfreq never
asked for anything above it), or after the observation window if it
stays clean. One caveat: this stacks on top of the kernel bump, so a
clean run would not tell the two apart on its own; if it stays clean
I can go back to the full range on next-20260831 to separate them.

On Thu, 3 Sep 2026 13:16:47 +0200, Konrad Dybcio wrote:
> On 8/21/26 3:35 PM, Rob Clark wrote:
[...]
>> Fwiw, the kernel I've been using: [1]..  but that doesn't have the a16
>> dts. I need to move forward to something newer, hopefully I'll get to
>> that today.  We'll see if I start seeing this issue.  Or maybe
>> something x2e vs x2ee is different regarding pmic/supplies?
>>
>> My device doesn't have the highest OPP (1.85ghz), which I think your
>> device does.  We might be still missing some power related features
>> that are (more?) needed at higher freq's, or maybe I have a more lucky
>> piece of silicon?  Akhil would know more about this.  You might try
>> removing the highest OPP in gpu_opp_table (in glymur.dtsi) to see if
>> that improves stability?  (Repeat until it is stable if you have the
>> same issues w/ 1.7ghz.)
>
> Greg, have you tried this?

Not yet, and sorry for the late answer on this. We have not run the
machine with the top OPP(s) removed from the DT for any meaningful
period, so there is no data point from that side; what we did instead
is the mitigation and the kernel bump described above. Rob's guess is
right: this is the X2 Elite Extreme part (UX3607OA), it does have the
1.85 GHz OPP, and it is currently running with the full range
(max_freq 1850000000, see above). Mesa here is still 26.1.5, the same
as in the report, so it has not been a variable in any of this.

Rather than removing OPPs from the DT one at a time, I will start with
Akhil's Fmax < 1 GHz test via the runtime cap above, which is
reversible without a rebuild and is also the most direct test of Rob's
"power related features that are (more?) needed at higher freq's"
theory. It is not quite the same thing as dropping the OPP (the GMU
still gets the full table, the GPU just never gets asked for the top
levels), so if the capped run stays clean, walking the cap back up, or
dropping just the top OPP from the DT as Rob suggested, is the natural
next step to find where it starts failing.

On the x2e vs x2ee question: I have no insight into PMIC or supply
differences between the two parts. If there is anything worth dumping
from this machine on that front (regulator state, the level table the
GMU is given, ...), tell me what and I will collect it.

The offer stands: at the next incident I will grab the devcoredump of
the first crash state in the loop, before it expires, together with
the full journal of that boot, and I can run instrumented builds or
debug patches on top of next-20260831.

Thanks,
Greg Ociepka

