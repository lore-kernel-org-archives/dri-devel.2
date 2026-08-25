Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E45C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D56A10E1B1;
	Tue, 25 Aug 2026 12:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/ayveOm";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345F210E1B1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:32:19 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-856c74cb7e9so14467b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 05:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661138; cv=none;
 d=google.com; s=arc-20260327;
 b=B1p/UUi/SbenY3OL1V0KzGrR8JocwRjn+XCOJSDrq8z5SJ4enlZQbLYigxKr+IBhwi
 vlizbxd+uTgQAODzu//glGjuJ/3jQqMxWhfCA6Gte1JDPTrbW/HS/xQbdHXTNo/dF1FY
 f9FbMlAaeAsdnQ23r6/QSGqLdhSU8MZ+wSgCC5gRwPvmYunNhnQ9d5twtjCxA+gXjzqX
 5Uv6fCoOgEpvWxrs8x/x9ttsyJqFouYE3674tYwybdPu2AEUWAoodNF44k/A/Qlk0gtQ
 9qqxqc2XwbRTMoZST05pKJ79W2A2MZ0EVIHHmqmX/HnBnNni3jikIVQpXsbe/6ma6Plc
 1FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
 fh=/zrFejPiMEibuf3kd3HbT/2pVz7+Gnf/PYFRtw6f8g0=;
 b=Qz6gjn4/rTlaf8uXKtJMspI50sgLPkhnWdk3CFAAEPwUnOrNfZdb8/aasHDujD8LKp
 7x1/ppKwM8qGi73UDq7Yjp+XXHXIjVpC7dm8ksxlqT+Z9AM8Gyf/x09V/uS0I2i4Zfw0
 cOUe9/YkKF7l9StZIZp0fIh3+ibs8sZKUv1xniZPHDN674bM5iUDo9rNU9nk0HKN+6Gf
 P8yhiycsCybBO9QyYvG0rdKRdbiDkhqRSnW9Wx6bPDwf27eW2ljPwyS+upL1kA2lYrgv
 KuokLcSkuXQLFlJkjaQZOzu+SAK+fxToLSSyYTcstfqziXivf1xOgZ4ny/8Mi3L+qlbq
 8kng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787661138; x=1788265938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
 b=e/ayveOmxH0Eq/m743BgJLKgzphdvC/2Wf7ao7xi5qW+EPvLjCZ7y6uMovokANjBUK
 qNc9s8C+MaKIDCEiteh2OWdE5q6sG5a9C5mnkIdaCTrvkafJeldfeZtirklqiDVQ97q+
 CSsxDmRkkQxOqlHd/f7xS8RDrDSLxYk86JWXGZXpO+pCEwPpAzqHpQ3ks3thW0BUAeyE
 dl7godLMek9BnksAdkCvj+YxRX6MLowXKaX4A04cwywIgd1CfTII8pqDW2XvS4tEmmm1
 fbVomAYf4VDpUdSY8YqFeE9s6IVoMhHqTJzsKURnoYRTSVGHYAnHpeVzTSCf16CZNTa5
 MLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661138; x=1788265938;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
 b=f4qiubUgFeYLakYQ35cyKJjTn1IlAvaPFap+3+6kKWkpz3I+KxRnPrE/WtpIw2/yff
 xQAriO0sJdXo9SzLD8moF791HrqmsyB2AUCso2e9hu+Do+guz7OVZpLT8ASn8KE1TE+g
 D3qz8wYdVFTyfkaowNB1nMw3t5SJTIfDxHbTvXHYcK6PGIXe0TrmI/Jo25u3npeXTIcR
 1Ql9ETnXlOSi4oPEikw+1IuSqXYEl2rfyj1c2GsGsAeRdWGTdVmOXLkAMMenOueUpSRQ
 2pwdwwh77wYi5iUngWoHgURc+y0bTJhhVgzbUJau5EqtaDXCdMoxC9BW2rpuaAIxmnRL
 YAQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhA/3DsPAmfGVKi15x5Knst2frEw7ezKkTPBxs9r5Y78Q53RIYSgh7SoiQj9OzSZ+a0w3lChEwFVQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRECdOpFQvd6GefKpQebbGCON9E4cZTi93QeJf0cJJl6QHipLJ
 lfqrcm6zW14UAh+Trlq8FAicMeW/ue7Zo1A6aDJ0UyKRp4eWbey0geXV0boqANY70sE7YUVwTEW
 tLwHRe/dhv4kzX9oBPQSYDP9b2cBKNO4=
X-Gm-Gg: AR+sD10zfgqV9bPgsWSw3bgI5svW2wMUsohxoALJ7fJvP5j7xStcM+MoPukvk8FDf2W
 uGCIkaGshj8wjWrY7LgGnjJAny5Q4WKMVqy+pJZNDVHpRMEx+WHAN6lFGr9wE7T1kjMdfdHkjir
 1etOd0KraKdMIKUzCui5o3YAiuSxaZTwGOg/TuQn3A/ddJECJ0vEumC41X8YA63K3VSh1K2wmL/
 TVJzjm4x8+1SLW0v6GUUxbigc2vFVydQNuJiuZBND4IiGgMuJUxQ0/w6yNlx50vViTLE40XyK98
 Exyea1XYbqvErAxkqakNrgMaIUuplPJA2gVX8dGM4kZHqhicZ92TU6Ow
X-Received: by 2002:a05:690c:6e01:b0:80b:d006:6436 with SMTP id
 00721157ae682-854c6f01138mr19294437b3.4.1787661138041; Tue, 25 Aug 2026
 05:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:06 +0200
X-Gm-Features: AcwNN1V1tG9pfMaEZxfyNcf1kB3QFf3O-ye-4Ztbjbyn2rv0eJ21NSEcDStkJdA
Message-ID: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Jiaxing,

On top of the as-is protocol re-run I reported on 2/13, I ran
one more arm with this patch added on top of 1/13 and 2/13,
same machine, same tree, same config, same JOB_TIMEOUT_MS=3D2.

Two passes (console_loglevel 8 and 4), 13 and 13 induced
resets, all recovered, oracle 48/48 throughout, including after
a forced autosuspend and resume.

The behavioural change is visible on RK3588. On the 1+2 arm, a
round that ends in a timeout leaves the affected core
runtime-active even through a forced autosuspend - the leak
from my earlier report. With this patch applied the same
sequence leaves all three cores suspended, and the next
inference still scores 48/48.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three
cores, induced reset, JOB_TIMEOUT_MS=3D2

Regards,
Igor

On Mon, Aug 24, 2026 at 1:09=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() drops the in-flight job's runtime PM reference with
> pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
> is left at usage_count 0 but still runtime-active with no idle request
> pending, so it does not suspend until something else asks, and on a
> platform whose power domain does work on power-on that work never happens=
.
>
> On RK3576 that work is a bus interface reset the domain cycles when it
> comes up. Without it the NPU's IOMMU stops answering, and the job after a
> timeout returns a surface of the output zero point with rk_iommu reportin=
g
> that MMU_DTE_ADDR is not functioning.
>
> Measured on a ROCK 4D in one boot, three runs, one variable between them.
> With the bare put the core reads runtime-active with its rail still up
> after the reset, the IOMMU reports the failure on the next attach and the
> inference returns 0 of 128 channels. With the reference put back through
> pm_runtime_put_autosuspend() the core reads suspended with the rail down,
> there is no IOMMU message, and the same inference returns 128 of 128. A
> third run repeating the first failed the same way.
>
> It also matches the put in the completion path a few lines away, so the
> reset path no longer leaves the device in a state the rest of the driver
> never produces. The remaining put, on the error path in rocket_job_run(),
> is a plain pm_runtime_put() and is left alone here: it unwinds a
> get_sync() that never reached the hardware, and changing it belongs in
> its own patch.
>
> Igor Paunovic ran the differential on RK3588: 45 induced resets across
> three cores, with and without the two preceding patches, and the domain
> dropped every single time with no MMU message on either kernel. So this
> is not rocket-wide. His conditions cross a healthy block with a lowered
> timeout rather than a hung one, which he was careful to say his protocol
> cannot settle, but it is what scopes the change to RK3576.
>
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
.com/
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3c0ed4605..a89ab49e1 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>
>         /*
>          * No handler is running now, but we might still have stuck jobs.=
 Let's
> -        * make sure the PM counters stay balanced by manually calling
> -        * pm_runtime_put_noidle().
> +        * make sure the PM counters stay balanced by putting the referen=
ce the
> +        * job took, and request idle while doing it so the core can susp=
end.
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> -                       pm_runtime_put_noidle(core->dev);
> +                       pm_runtime_put_autosuspend(core->dev);
>
>                 iommu_detach_group(NULL, core->iommu_group);
>
> --
> 2.43.0
>
