Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA206C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320F410E40A;
	Tue, 22 Sep 2026 14:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxP/vKDS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC1710E40A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:07:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EC3543E5F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753761F008A3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790086033;
 bh=kUHXPatxl6UDjnbGBaoNIDKARQ2zRd+ziWNoZ41+0RM=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=lxP/vKDSiXT2QGOjMIwkk3x+yEAYCg2kJyuUM6sWk61hBHI9ZWFXn5G0ON/R2yVT+
 zwONGAOeAX3B9UVA+3REtPbCJk5Cji0J7nkUkiVMR+dn2FJYQeE5Z4o6D84gtjpApt
 0diQvRJaXTedqcS6LHpxvIn6TTeUaEDLIouEH5yDggoLepDNpU6vVIfJldSz5GUJWF
 2YjVFU5CmczjIuIfGBYRmQ7Q8lhEjd016Ly8lUq310AKO3n9Z3lqNqwehCuaelMF15
 oXcewccnVgfCntfsVJzTBQrEWqHq7JiPBCK2Ds1AGkOaVGHH9QTKH/C6CJq/r8K3lm
 mrEwwIyjTUNhA==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b74e0c2e4dso3812258e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:07:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzqNZPUJNxVvh4Ii/p3EeQ33Ju0I64wreCIcNBOhFSy+KeOCFaSGTb9coZTH32/W1LUaIAf4SqEK3A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRlVaXXOvQK0s8Dmym3t0r2vLQdTbIUHQG9VxVy83Bmnk1aAQx
 iaf5L/fLf4VWFzQAIVwSr+yQgW4N54i/ssEsRVVNRi6QRIFyBMiHYfLh9sFqeyBSif3NUaBaQNG
 V1RsxO+IKiLmuxMAX9DoyLqt9MqaVf8BCj91ALtesOA==
X-Received: by 2002:a05:6512:3c89:b0:5b8:bc5e:b584 with SMTP id
 2adb3069b0e04-5b8c195dba5mr4212786e87.60.1790086032032; Tue, 22 Sep 2026
 07:07:12 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:07:10 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:07:10 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <arJY1TMBIZCy8E7n@black.igk.intel.com>
MIME-Version: 1.0
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
 <20260716-swnode-remove-on-dev-unreg-v8-3-5c2b8cc38c28@oss.qualcomm.com>
 <arJY1TMBIZCy8E7n@black.igk.intel.com>
Date: Tue, 22 Sep 2026 07:07:10 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfKw=r_Rq5jLqRQ9PsfiWoQ9y9EJFkpdWraLsPoK3m52w@mail.gmail.com>
X-Gm-Features: AcwNN1UEx80-dq3niB3Ch-hprwiz9M1bLoeYBSF0qAEN-wKYR-Jy-u3bvPVw6Es
Message-ID: <CAMRc=MfKw=r_Rq5jLqRQ9PsfiWoQ9y9EJFkpdWraLsPoK3m52w@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] drm/xe/i2c: use
 device_create_managed_software_node()
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 brgl@kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 22 Sep 2026 12:30:45 +0200, Heikki Krogerus
<heikki.krogerus@linux.intel.com> said:
> On Thu, Jul 16, 2026 at 02:31:38PM +0200, Bartosz Golaszewski wrote:
>> This driver intentionally uses the fine-grained approach to creating
>> platform devices. It assigns a software node as the primary firmware
>> node of the device it creates. Ahead of improving the reference counting
>> of platform device software nodes, switch to using
>> device_create_managed_software_node(). This way, we create a dynamic
>> software node whose life-time is tied to the device to which it's
>> assigned.
>>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>
> What happened to this one? I can see the commit 0f485f88656a
> ("drm/xe/i2c: use device_create_managed_software_node()"), but not the
> code change?
>
> There is no revert and there are no other commits touching this part
> of the driver, so it's as if the patch was never actually applied?
>

I had no idea what happened here so I had the robot look into it and it cam=
e
back with this:

--
Your commit 0f485f88656a ("drm/xe/i2c: use
device_create_managed_software_node()") landed upstream on 2026-07-16, but =
it
went in through the driver-core tree (it's signed off by Danilo Krummrich,
a driver-core maintainer), not through drm-xe. It reached mainline via the
"Merge tag 'driver-core-7.3-rc1'" pull, and was present in v7.3-rc1.

Meanwhile, Intel's drm-xe-next tree had last synced with mainline back on
2026-08-06 (merge-base ec3e9419371d, before your commit existed). Off that
stale base, Heikki Krogerus landed a large I2C IRQ-handling rewrite on
2026-08-11 (a55b76b8bc2c "Fix the interrupt handling", 76cc14e2faed "Keep
the i2c controller always enabled") that touched
xe_i2c_register_adapter()/xe_i2c_unregister_adapter() =E2=80=94 the same fu=
nction
your patch changed =E2=80=94 but built on the pre-conversion
fwnode_create_software_node() code, since drm-xe-next didn't have your comm=
it
yet.

The regression happened here:

cc467969646b =E2=80=94 "Merge drm/drm-next into drm-xe-next" by Matthew Bro=
st
(Intel), 2026-08-31, merging:
- parent 1: drm-xe-next's tip (Heikki's rewrite, on the old fwnode code)
- parent 2: v7.3-rc1 (mainline, with your new
  device_create_managed_software_node() code)

I diffed the merge result against both parents directly: for the
xe_i2c_register_adapter/unregister_adapter hunk, the merge commit is
byte-for-byte identical to parent 1 =E2=80=94 it silently dropped your API-=
migration
change and kept the old fwnode code (plus Heikki's IRQ rework on top of it)=
.
No Conflicts: trailer is in the merge message, so this wasn't a manual
conflict resolution that anyone flagged =E2=80=94 either it merged cleanly =
in a way
that just discarded your side, or it was resolved without git noting it in
the message.

That merge (drm-xe-next-2026-08-31-1) then flowed drm-xe-next =E2=86=92 drm=
-next
=E2=86=92 mainline, and it's still that way in current mainline (verified: =
HEAD,
v7.3-rc4-based, still has the old code =E2=80=94 confirmed via git blame).

Bottom line: your change wasn't reverted on purpose =E2=80=94 it was silent=
ly clobbered
by a stale-base merge conflict resolution when drm-xe-next resynced with
mainline on 2026-08-31, because drm-xe-next hadn't picked up your
driver-core-authored commit before building new code on top of the same
function. This is a real upstream bug worth flagging (to Matthew Brost
/ Heikki Krogerus / Danilo Krummrich): the driver-core migration for xe_i2c=
.c
needs to be reapplied on current mainline.
--

I think we need to reapply this patch.

Bart
