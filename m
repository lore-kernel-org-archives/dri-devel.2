Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B53C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C992410E671;
	Mon, 10 Aug 2026 06:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATpW9KhA";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3FD10E26E
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 17:51:01 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6b03e59a9b4so209612eaf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 10:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786125061; cv=none;
 d=google.com; s=arc-20260327;
 b=RKwALQkKuoFMvIeDgUJHVZIwTC+bL4xm+BuplKNtZdx+WxMpVBUxm+mmQaqw4Nr5td
 cbH56hs+7uoF5ImNghX6Cs+/DN1moQ1rw3plix31SKKG+gWvtrem9gWRYm8B9Tl6DVOH
 WTh9ezUpUJPAakZ+HOo0sTo2fdAgWpfENKP3QVy3zeHy5SJ2sMp35H4hxN+IU9dfJ/1u
 6HBDpK41qnpwbeHMLLpf4i5490f+sB98FLRPuHOY96Q7sACk6DTZak3x4yQSyxebNRex
 XgYEEkQ98cXkbfQeAqH4B+Fx/0SeqDnoqGwleRBxOw7FMq0KprenLIGBaHRD2J36Kq4p
 iBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lRjAT478Uz3ZQXBeUJ/wQtNqpl6lKAtydNqvVxPKT04=;
 fh=0DcgYhH/Uc7bKxl+LBYM4zAtwghUoOVts+QzscfRmBE=;
 b=ioKnGYLH6tQy57CuXNt9QRu/TYqdka2DaIvMiQHPhN8x1C10tXwUFKMYLf/T29aQKf
 Uu1GWdxvBcKJ+PCgsAjTRloZJKI3dlHDGkuGRNHWEmLgWeBgCBhdpVglXRc+NgzHlt5q
 FMZAMohaNMmXsCvGr6KIcx2a+95SCDhgg6XDbpTEAQQDsILzn/tOF5rmXOukEgM3V4j7
 8as/FhxtL2HlWIEfrgogv4JuuD5r+sqzYn5B3d8DpGAJNqNw1gBPP0EpKhmV3bpy1Bno
 vAMcVZ5TwQFRgJ8nvLhCJH2PEEyqSch+qli2kQZWGBf8zjhbkNsC00h9FTbsf/o/bLZd
 0wYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786125061; x=1786729861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lRjAT478Uz3ZQXBeUJ/wQtNqpl6lKAtydNqvVxPKT04=;
 b=ATpW9KhAf397b2tQUhTT/WXt3OqcaN/lgJyZWYJgJBS4YqIPHPIW3d5Nag1PXAe5m3
 /3GEx97T7Y9RWBy/aL3HtE+MEYWE8xKTKPmXJXjVzIN8LyeIPBzLjM8myl/k16+9HkQX
 j9B30bN6vITh1TnE2Nwx5hT3fZ4BJYEMMPvC1BgVFUioZXcM6KbGShUVXWsb9ef+z2Pr
 tWSPCe8Sx8FRnIhCpn1FwLGvngprbflNiX/7z6WJra9bldFbq/SwZIW2wK/iRFvDDQWu
 7nOq8sn8GuETm2+lSCbV8poO6bdPonycQwpng3tEheQZScBsyjfpcgo2Eq5hhdPor4UH
 94cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786125061; x=1786729861;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lRjAT478Uz3ZQXBeUJ/wQtNqpl6lKAtydNqvVxPKT04=;
 b=s03lQJzSj3UUwtYgvKdJL6JYc1uHEPnLeqn2TV1zHnZrYj8XFn6Gx1Jo2FLhU+abht
 ir4+cVlYt3U2HYzvBQENFzfnsS6XlA1tGgQ+CR/FE9QVzZsq7IMHNyb0TWXs+5VekXLq
 9tqoisMDbUsoUsIMWG7w63CNzKpdDF9Zz1i9fvqeG18kbq13sYmJ8SHjUxRGBZM24E34
 irA4xXAEhlUm6wHQ3hIM8sBWlOJYNAIukAwnyb+vzvVza+r3GhPgvvIFDMVAAYu2M9tQ
 51xZlqatmihHH7WPxUB+1iZD9Iuuvx/294Ji0Sb3kJniLTFFNYF80n3oxrvchVTfkul6
 ojnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlEkUNLw3Xwi4Pdvwd4LTCdqqnEj3WaQH2GVuDX+qmB11z0SNe36F55ZQd45tEHhyaB5F0V6DqJNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1aOjrNXeELCoZp6CPqhVEWxF/nNhwK5JMNkeFPDPQS+vUlxuq
 WbNEsCbcTKJKNtqNkdj1rkrAXeXDacigpXRjy87TYtDcxgl52l7XW+0kRC6+Et89YwzLv12swgn
 OFlw+5nxEqIA2N6iGLdMpLi34ylWJZQg=
X-Gm-Gg: AR+sD11QDdDfh6qngY4UYiqvc4syTbm5y58kLCdLgvfTqAdkeEdSDnH11FK0CuiJx/m
 QqN11NSGHoPENkaOIB2E1cZo9WRO5kHa7VYbqklkievtlOcj8hQjMExYcgv0JfEb5G+4vB+bRHc
 vuyHRyA3y8+HgswwozxcdZOawZLSrmDEcU67pAywTQ+y1FsCizfChQ/x0Bwdt/Zzu2C7KVnxJeC
 mtPWvTUyza1lJ3v2bYPGxdOYI6hXvLmipF98wXGW7YGFMPZ1pfO8gJ9fNh1zNK5frbXceDRNDZy
 9qs1AW6KVhjSKUnKeDbOBDdbTv69ul3kH7UUdSM5L0d36KXgk5NaPu04t8+RSssyLH1prm5jj4g
 MTQ==
X-Received: by 2002:a05:6820:811:b0:6b0:40d9:8ac6 with SMTP id
 006d021491bc7-6b041f594b5mr991109eaf.9.1786125060721; Fri, 07 Aug 2026
 10:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260728091804.382753-1-wenst@chromium.org>
 <amiqKRkFItYwD6oL@redhat.com>
 <CAGb2v64zUO-azpTuei6LCypad2noGFbg+EmaBC1iidoZ2stQzw@mail.gmail.com>
 <c1048eae-72c5-4e2e-ac49-25e2c4297018@collabora.com>
 <CAGXv+5EgGYFVt4TJCysQgRqA1J5=Qz9c0oWY5YTxgc5PnNC_AQ@mail.gmail.com>
 <36f2775a-d332-4913-8e9e-ca0429c3f713@collabora.com>
 <amswFn2qWkvypMH8@redhat.com>
 <CAGb2v65yEtUH5LQ=kGL1io-urha12iOute=D2bbG872YXbK4fQ@mail.gmail.com>
In-Reply-To: <CAGb2v65yEtUH5LQ=kGL1io-urha12iOute=D2bbG872YXbK4fQ@mail.gmail.com>
From: YoungJoon Lee <getfeus@gmail.com>
Date: Sat, 8 Aug 2026 02:50:47 +0900
X-Gm-Features: AUfX_mw5H1veunrAd0DWILURr17Bo7nhldWDJMLG41xotTB7eMODtkVZIaJFjgA
Message-ID: <CA+m4KrDpcdJZBXT5wN+NHV+BtLLT-suhamCmzg+gUhamvbPR8Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powervr: MT8173 GPU support
To: wens@kernel.org
Cc: Brian Masney <bmasney@redhat.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Chen-Yu,

A follow-up on the GX6250 issue.

I ran the diagnostic test I mentioned in my previous reply, and I now
have a reproducible system hang along with HWRT/free-list lifetime
traces.

I built a diagnostic kernel with temporary tracing around the PowerVR
HWRT and free-list lifetime paths, and ran:

PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 glmark2-es2-drm

The test was run from multi-user.target with no display manager running.

This time glmark2 progressed past the point where it had previously
failed, but later the entire system became unresponsive during the
desktop/blur part of the benchmark.

At that point:

- SSH stopped responding
- local keyboard and VT switching stopped responding
- the system required a hard power cycle

The HWRT teardown trace immediately before the hang was interesting.

Normal HWRT destruction repeatedly looked like this:

dataset-release
-> HWRTDATA cleanup data=3D1, err=3D0
-> HWRTDATA cleanup data=3D0, err=3D0
-> free-list release slot=3D0
-> free-list release slot=3D1

For the last HWRT visible before the machine stopped responding, the
trace ended at:

pvr-hwrt: dataset-release hwrt=3Dffff0000c0c62800 ...
pvr-hwrt: cleanup hwrt=3Dffff0000c0c62800 data=3D1 err=3D0 ...
pvr-hwrt: cleanup hwrt=3Dffff0000c0c62800 data=3D0 err=3D0 ...

There was no further PowerVR trace before the system hung.

Therefore, I do not think I can conclude that the free-list reference
counting itself is the root cause.

What I can say from this instrumentation is that both HWRTDATA cleanup
calls returned successfully, and the trace stopped before
hwrt_fini_kernel_structure() reached its first free-list release
message.

The tracing is intentionally verbose and may affect timing, so I do
not want to over-interpret the exact failure point.

I have the diagnostic patch, the full kernel log, the HWRT/free-list
lifetime trace, and the glmark2 output available.

Would it be useful for me to send these to the Imagination/DRM mailing
lists now, or is there a particular person or list you would prefer me
to report this to?

If there are specific additional tracepoints you would like around
hwrt_data_fini_fw_structure() or hwrt_fini_common_fw_structure(), I
can build another diagnostic kernel and reproduce the issue again.

Thanks again for taking a look.

Best regards,
YoungJoon Lee

2026=E5=B9=B47=E6=9C=8830=E6=97=A5(=E6=9C=A8) 21:38 Chen-Yu Tsai <wens@kern=
el.org>:
>
> On Thu, Jul 30, 2026 at 7:06=E2=80=AFPM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > Hi Angelo and Chen-Yu,
> >
> > On Thu, Jul 30, 2026 at 10:23:14AM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > On 7/30/26 06:51, Chen-Yu Tsai wrote:
> > > > On Tue, Jul 28, 2026 at 10:33=E2=80=AFPM AngeloGioacchino Del Regno
> > > > <angelogioacchino.delregno@collabora.com> wrote:
> > > > >
> > > > > On 7/28/26 15:13, Chen-Yu Tsai wrote:
> > > > > > On Tue, Jul 28, 2026 at 9:10=E2=80=AFPM Brian Masney <bmasney@r=
edhat.com> wrote:
> > > > > > > On Tue, Jul 28, 2026 at 05:17:58PM +0800, Chen-Yu Tsai wrote:
> > > > > > > > Hi everyone,
> > > > > > > >
> > > > > > > > This is v4 of my MT8173 PowerVR GPU support series.
> > > > > > > >
> > > > > > > > This time around Mesa was ready for basic testing, using bo=
th vulkanmark
> > > > > > > > and glmark2-es2-drm (with Zink). Details below.
> > > > > > > >
> > > > > > > > Changes since v3 (all in the clk driver patch):
> > > > > > > > - Changed pm_runtime_put() to pm_runtime_put_sync()
> > > > > > > > - Added missing of_node_put() in remove function
> > > > > > > >
> > > > > > > > Changes since v2 (all in the clk driver patch):
> > > > > > > > - Made COMMON_CLK_MT8173_MFGTOP depend on PM
> > > > > > > >     - Needed since the driver implements PM domains using t=
he generic PM
> > > > > > > >       domain library, which also depends on PM
> > > > > > > >     - Fixes build breakage (kernel test robot)
> > > > > > > > - Fixed "RST_DELAY_CNT" name (Brian)
> > > > > > > > - Dropped unused mfg_desc (Brian)
> > > > > > > > - Added check of clk_prepare_enable()'s return value in
> > > > > > > >     clk_mt8173_mfgtop_power_on() (Brian)
> > > > > > > > - Saved error value for return in IS_ERR(data->clk_26m) bra=
nch
> > > > > > > >     (Dan Carpenter / kernel test robot w/ smatch)
> > > > > > > >
> > > > > > > > Changes since v1:
> > > > > > > > - Adapted to changed DT bindings
> > > > > > > > - Dropped driver change
> > > > > > > > - Use same power domain for "a" and "b" GPU power domains
> > > > > > > >
> > > > > > > >
> > > > > > > > This series enables the PowerVR GPU found in the MT8173 SoC=
, found in
> > > > > > > > some Chromebooks.
> > > > > > >
> > > > > > > I'm making a pull for Stephen for the clk changes. Should pat=
ches 1,2,4
> > > > > > > go through the clk tree? Patches 3,5 go through the DRM tree?
> > > > > >
> > > > > > Only patches 1 and 2 should go through the clock tree.
> > > > > >
> > > > > > Patch 3, 4, 5 can all go through the soc tree if Angelo wants t=
o pick up
> > > > > > DT binding patches. Otherwise I can push patch 3 through drm-mi=
sc.
> > > > > >
> > > > >
> > > > > Not sure if I can really take the DRM bindings patch through soc.
> > > > >
> > > > > I will take the devicetree ones exactly right now, even though it=
's going to
> > > > > give warnings.
> > > >
> > > > Apologies for missing this, but the first DT patch depends on the c=
lk DT
> > > > bindings patch for the clk ID macros. This is causing build errors =
in
> > > > linux-next right now.
> > > >
> > > > Not sure how we can fix this right now.
> > > >
> > > > Brian, would it be possible for you to split out that patch into a
> > > > separate immutable branch for Angelo to merge?
> >
> > Yes, I can split things out and make an immutable branch this morning.
> > But it sounds too late for that.
> >
> > > >
> > > > Otherwise Angelo might need to drop the DT patches until the next c=
ycle.
> > >
> > > Yeah, that's so bad.
> > > I'd be happy to be able to resolve this, but it's too late on my side=
.
> > >
> > > I should've checked the DT patches more carefully, my bad: I got a bi=
t too excited
> > > to finally see this PowerVR stuff working on MT8173 and going upstrea=
m.
> > >
> > > Sadly, I have to drop the devicetree patches :-(
> >
> > Chen-Yu: Could Angelo add an Acked-by to the three patches, and then I =
send
> > Stephen an additional pull with just those patches? Do you think he'd
> > pull that?
>
> (replying from my @kernel.org address again because I don't feel like
>  pulling out my work laptop.)
>
> I think the question is whether the soc & dt maintainers would be bothere=
d
> by it or not.
>
> No need to sweat over it though. It's not like the GPU driver is producti=
on
> ready anyway. We can just merge the DT patches in the next cycle. :)
>
>
> ChenYu
