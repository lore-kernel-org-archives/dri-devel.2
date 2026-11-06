Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465F606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=CoEmUfaY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2672410E350;
	Fri,  6 Nov 2026 06:11:21 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208E510E350
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1793945416;
 bh=dlMB2EQjuzBySmR5GqJBziBOr+KKGv+oGqz2McQg0Ss=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=CoEmUfaYL00ZRlWq6ulYaVkNZeN1ZD+oNWBABhrwQYxaFtvOnN9pwRBSLFqh06Sag
 4ZqWGNbpBo5bEhwIdg4CHV1E9yXk4Kzwqm6LtKzDaiSs9h2all9wJqzNkNK7/yX+of
 WnwoMnfoY2evLp4/GtEdziIhXoAC6VjsWuZKbTSU=
X-QQ-mid: esmtpgz12t1793945414t31773276
X-QQ-Originating-IP: TvjStvLttQ2jKx3rjkbSQUng+nHe5KV9P0Hm81jxCs8=
Received: from localhost ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Nov 2026 14:10:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 186222589772570272
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 14:10:12 +0800
Message-Id: <DMNWKP4OI5IT.2S74EHH6A8Z6G@linux.spacemit.com>
Cc: "alessio.belle" <alessio.belle@imgtec.com>, "luigi.santivetti"
 <luigi.santivetti@imgtec.com>, "maarten.lankhorst"
 <maarten.lankhorst@linux.intel.com>, "mripard" <mripard@kernel.org>,
 "tzimmermann" <tzimmermann@suse.de>, "airlied" <airlied@gmail.com>,
 "simona" <simona@ffwll.ch>, "dlan" <dlan@kernel.org>, "imagination"
 <imagination@lists.freedesktop.org>, "dri-devel"
 <dri-devel@lists.freedesktop.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv@lists.infradead.org>, "spacemit" <spacemit@lists.linux.dev>
Subject: Re: [PATCH] drm/imagination: retry runtime idle when firmware is
 not yet idle
From: "Baihui Liang" <liangbaihui@linux.spacemit.com>
To: "Gyeyoung Baek" <gye976@gmail.com>, "troy" <troy@kernel.org>
X-Mailer: aerc 0.17.0
References: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
 <DMHSRIU2XCB0.35RV6ADY6W1IE@kernel.org>
 <CAKbEzns6CYjNXmf4jTx_eGSH2j6AjpKJPx=EtoqxweGLiQ85JA@mail.gmail.com>
In-Reply-To: <CAKbEzns6CYjNXmf4jTx_eGSH2j6AjpKJPx=EtoqxweGLiQ85JA@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mu3aYh3HTI2CfA3DbH1+/ECd7lmAV2dECgRZNITU7LG6dnIjVxNFRVzI
 NKaFK5l+QmPHs8ne9BGYbWQmyTiMw323QPuShe21vEmzrvPG+ltBgQMbct+VUuAIcnNubdL
 ++swluNlakB5XG0DRnxIZxJP8er9qYhvkL2N+gh/81nmtaiYvDwaC/HMo4akMNyRuLFJ64A
 IudlXhszwlZzIgpnk0boIhiYK51jSGLFlVnnSnlqhyFYhDWJXUQ//zP+ZKrbpDVwpbFDnEx
 lQPze337Th9M7F+hteStV1GeOuO+DSATxQ6tGwEBqD2hoXAYZmBgmjqgrZ1Rl1YvIKChC+U
 YEjdiuJNSj46wiYovsN1ci5jQD3o837+AOrA8yrSD90gtQ8mfFlUp1QN3UbomjGBzfP2ALV
 KdxwKQcr3R7ewFAyZMDX1g92nwGUvOWcmXVjRnh83ZunHHcAgl/q9MrxhpiIbT6+LJd7Sp9
 5kOJBj7vEiZVVloRQrBAVptrp+Mhg8cUGX8whFTfm4v14ZjlKZ3ecTd7lUAzot+JsvA2W1r
 JfLBdeejFrtoI5rT9JIePZdNSpd1FDxFM3bRQw5cfXkcILlgf3S1i8Na+2J5U9ClpVbYmng
 vFCLSugqW5geg9bSs7Pjc97c/jJNGWTgisc45VJLLT4BwkPlUbzhx+jYmjF2STD188L7gS7
 xu8Q7XwEAzzmznTrm221kwL28Rh3s4j1FX9LaSb2ba0sXim0hKD0KTcVE/sczqeHRd5hRuD
 /xHEoutcg0XcOu5U4PrBpz0dCB9yzIddS5+pMtn1zbbDbrBB9SCvh2+BDlyD3dIGUmDgJoM
 j7wfAyrP3z7rwb4q8f7Q4q+3IYTl1Pi/OxkpeshPJLvzCLVAHL4Sa41RHqXQE1jl4OPKpmI
 4j89GXO7g2I6I0n7st/L8xCXmtnKFykReSK0bQbHzZHloPBK1S3SmOLzd2afl0V3J8n5GnO
 wYI+WTcxrxevnhY6Hc2ppZf9FwSOwcIaRrOuCga3eZ8n0SA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Thanks for the review. All three of you are right, and v1 was wrong.

On Sun Nov 1, 2026 at 12:34 AM CST, Gyeyoung Baek wrote:
> Hi Baihui, Troy,
>
>
> On Fri, Oct 30, 2026 at 10:55=E2=80=AFAM Troy Mitchell <troy@kernel.org> =
wrote:
> >
> > Hi Baihui,
> >
> > On Thu Oct 29, 2026 at 4:38 PM +0800, Baihui Liang wrote:
> > > Returning -EBUSY from ->runtime_idle() prevents the PM core from
> > > retrying the idle check. Schedule an autosuspend so the idle state
> > > can be re-evaluated once the firmware reaches ROGUE_FWIF_POW_IDLE.
> > >
> > > Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
> > > ---
> > > Tested on SpacemiT K3 (PowerVR Rogue BXM-4-64) by running vulkaninfo
> > > repeatedly. Without this change the device intermittently stayed
> > > runtime-active after the last user went away, because the firmware ha=
d
> > > not yet reached ROGUE_FWIF_POW_IDLE when the idle check ran. With the
> > > change the device reliably suspends.
> > > ---
> > >  drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/dr=
m/imagination/pvr_power.c
> > > index eb4b6ecdf4f..6f38249ffcb 100644
> > > --- a/drivers/gpu/drm/imagination/pvr_power.c
> > > +++ b/drivers/gpu/drm/imagination/pvr_power.c
> > > @@ -434,7 +434,16 @@ pvr_power_device_idle(struct device *dev)
> > >       struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
> > >       struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> > >
> > > -     return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
> > > +     if (pvr_power_is_idle(pvr_dev))
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * Firmware not yet idle; reject but schedule autosuspend so
> > > +      * runtime_idle() can be retried.
> > > +      */
> > > +     pm_runtime_autosuspend(dev);
> >
> > If I read the PM core correctly, when this autosuspend timer fires it
> > calls ->runtime_suspend() directly rather than retrying
> > ->runtime_idle(), so this looks equivalent to returning 0.=20

That's right. It merely delays unconditional FW teardown without
re-checking idle state. I'll send v2 with a different approach.

> > Could the
> > real issue be the pm_runtime_put() in pvr_watchdog_worker(), which
> > perhaps should be pm_runtime_put_autosuspend()?

That put is only reached when pm_runtime_get_if_in_use() actually
returned a reference. Our stuck-active case was the opposite case: the
device was active with a zero usage count, which jumps directly to
out_requeue and skips pm_runtime_put entirely. Changing this call
won't help.

> I think sashiko's point is valid.
>
> Calling pm_runtime_autosuspend() from pvr_power_device_idle() when the
> FW is busy only adds a delay, and the device is then suspended without
> re-checking idle, and this is effectively the same as
> returning 0. I guess it worked in testing because the FW was busy at
> pvr_power_device_idle() time but reached idle before the autosuspend
> delay expired.
>
> How about moving the pvr_power_is_idle() check into
> pvr_power_device_suspend() (and dropping pvr_power_device_idle()), and
> returning -EBUSY after pm_runtime_mark_last_busy() if the FW is busy?
> The PM core then reschedules the autosuspend regardless of whether the
> last put comes from the watchdog or elsewhere, so suspend is retried
> until the FW becomes idle.

Agreed, v2 will follow this approach.

> I think this is the pattern described in
> Documentation/power/runtime_pm.rst, section 9 ("If the
> ->runtime_suspend() callback returns -EAGAIN or -EBUSY ...").
> --
> Thanks,
> Gyeyoung

Thanks,
Baihui
