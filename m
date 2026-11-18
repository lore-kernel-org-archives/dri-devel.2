Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFA606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F6GjQA6n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1AB10E41A;
	Wed, 18 Nov 2026 08:58:36 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAC110E41A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:58:29 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-9495e8ae23aso67646685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794992309; cv=none;
 d=google.com; s=arc-20260327;
 b=lvX2DiduclM6LwAXVwv/RddRBEP/uMfrDQQW9z+rseB9kiP81KfUzbnecwTDvQ0iF1
 g5I4Nj+EkgNWR9uvso4Kag1BGazg6rcc5Uu1hUACkNFdVtlX/E4rBhvyUSGfYGcdYbVm
 QlUYwgFiBEwvQKjA467oD4m2gqoe7YimHDaSc8gYseMmCYk0djEBfvGQJu9aBSY42I8p
 y2JmQF3LRiRdg6TT8G/5TvRGEkU/nx8sV2uHRt5emkMm2enZycWuVfrpfbBEKdPRnhgO
 em7pQxcpp+HRh1/VqLP7ZYt5czw+N5TITA2HYNKIXtC8E9pqvBMI6prq8QkmRURvPoDd
 J1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Tn6QZlBwdQy7Z++SGRb83hx1wIds9xXetCQNFKWLw4=;
 fh=1xupNvNfbNEHHSCMF+eM+LOtOoSXOhJxvKmIqvg1+xc=;
 b=E7WsTNVMVX3sFyeE7jAdL2g/34d3dehgm31uwoeRhSK3lGClrI27UHE9KBssT7TlDI
 qNvoe8ZNcxjY9ks5E9flk9MfHVpEUISF3dDQbgr1TAVlTQEeEGcyIeZKjgwFTRRQAaPR
 Amfy9JyYPIW5yqbnHWWh2v0zRFP4f3nHd1l5AcplvFOej+Ml8uUuWvYE2Z+t7U6uGm0a
 Ey3Y4xK0i4wwTZvqHHnFFqHYWQ8PiGAROvnkYMwEUAkVZpt1DeO2DFNNBec6URK0JCjO
 yW+AU1FKabb6l9o0fhf5hNK/jNoLQV+hqJo/26q5pwAKhQpvVmp+UoSPX9tbudphKwVu
 ADmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1794992309;
 x=1795597109; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Tn6QZlBwdQy7Z++SGRb83hx1wIds9xXetCQNFKWLw4=;
 b=F6GjQA6n4TRg2fXiHrbaT1YbvrIb9bli/CkSYYEqDcoirzDSYGx8JrALtnM1kD2Sby
 NEaIvYkSIHxnyegAI09lAr6xGltJYP0ZjcZaOzGpv0vSxhAAMEuvcy649pM5SBTqaEnC
 gmkOXoilZdoFA50OBmA0BehqYXFt0IQjDNBhVPHlFnw3LQld+WEblAbfs1590mnWhm8B
 LwbrRs6MzCp/85TEgUIvXbpFfzlaLe/EnuRcP/rZdPv7HhDlLn68qZpi7qC6b46czc/h
 ZHXpAFoElITAFn91pMfTozEumblQsqfOYD4hEltgY70PDFkCdiNmWpOR3Ko8gNZcTUmz
 MOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794992309; x=1795597109;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Tn6QZlBwdQy7Z++SGRb83hx1wIds9xXetCQNFKWLw4=;
 b=tYpvWS/heR9zPN+jErdi46r/2D6tYJK2SFa/+ANwRnoe7i2P6tVqiR9JBdH9ses/ax
 ZzxY78JfBxb5jNpEF5BPAGQ0T8cgFe9LYjImLreNQUWrFrAqCiPaejqLPh9h8fv7h1EO
 mFi5JHRiR90dPhvw6A2ussav0V/9Ay7f5+5zCPuiX92uJ0sZs8QpCXSGVG6MfYF2YjqX
 9yiMhM52cZraHiGFYurhvNUgEAcYnP6mGe1jNadxKXI20WCOl99Of0UmozRVVGWoew+G
 kFv16rrVXotG2RvKE3YT8hl42vAZlzFKfBOt8GK4Qv/nyITXHy2HR88VBHLlG7KGcWoR
 gVWg==
X-Forwarded-Encrypted: i=1;
 AL+hErEnlLUFkSBJ0Ovd8tGzkgQmpE0Crjkls1pMEZmHhEqgoFPpOCM+bM2XhvS63Dr+UwU5ZM4HpUZ1/RQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZuasmcaK2FMjv9tjDf6Xgm5vkL/JXad/pbNzUofikc/NPFD4W
 wDQlt5clsFOSc9vwQWRjwaMuoktCI44Y3N2V2sGvDQBsKfV7peloo9ZhbtBpibKTL/Z2u48LkG5
 rKRtAvmCRKQs1eprYvEKMxuQF2TmmLuAGqYn50h8gaQ==
X-Gm-Gg: AYBFou2z832t77LfAW+QJX3oF4QDQ0aq1BX2sRkuLN16d8hib3yEKRXjL0Rzo3hPzAc
 E0ZAxp7pSu+Kkbcdf16J+tad9Z8HxRGNXs5/cYguuB9d6jylQYOQJpLAytD1znz4M4a7pDnArzi
 Gpo3r1e+R4nxJRFFyBCep8Ib8CiJJp73YoYZJZkOiZHbJcP0DEvpHmCEpiAUQySvbndTqXtQGLH
 3XZGGKlkSwot/9+waZnh1sfO0JP7eoMuyNhQlG6Y2U0k1cRCZ/kMgg+DV+GRZGL+xQh/1EBJUYm
 u6l8+qvutS+uiLtyYWHkQqfRre8fTLjNTCwAkBJ13+0vaI4s8tI5nAldSKFde0l8ACyrhewXApP
 TSEsYkMZfBcZVJFxjS9io7Rm5+VfBp2TfpddcB8XNe9AlIY/FpWhm612hq475GVHjo3cBnYJvsz
 4gAT1CiK09nvTi79ChgIg=
X-Received: by 2002:a05:620a:8086:b0:949:8119:6702 with SMTP id
 af79cd13be357-9499948e137mr355118385a.10.1794992308643; Wed, 18 Nov 2026
 00:58:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-4-kernel@airkyi.com>
 <0e722f43-f08c-4636-bf3e-0dbe991bf6a0@baylibre.com>
 <72957827-fde8-4f4b-80a9-050d2f112316@rock-chips.com>
In-Reply-To: <72957827-fde8-4f4b-80a9-050d2f112316@rock-chips.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 18 Nov 2026 09:58:16 +0100
X-Gm-Features: AclHuK909rrF_qXtOz1nnqKagNl32jQy-qVgmtzBVAZUdG_WOuXBZplBLfDYBaA
Message-ID: <CAPsqS2QhAortoDOt9MBizTr4RCDhChr1xLF13NNTUYjyFMakhg@mail.gmail.com>
Subject: Re: [PATCH 3/4] accel/rocket: Fix the extra iommu_group_get call in
 rocket_job_handle_irq
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Daniel Drake <ddrake@baylibre.com>, Chaoyi Chen <kernel@airkyi.com>, 
 Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, LKML <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, 
 LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi and Daniel,

On Wed, Nov 18, 2026 at 3:29=E2=80=AFAM Chaoyi Chen <chaoyi.chen@rock-chips=
.com> wrote:
>
> Hi Daniel,
>
> On 11/18/2026 5:53 AM, Daniel Drake wrote:
> > On 14/08/2026 03:24, Chaoyi Chen wrote:
> >> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >>
> >> The rocket attaches the IOMMU group in rocket_job_run() and detaches i=
t
> >> in rocket_job_handle_irq(). Calling  iommu_group_get() in
> >> rocket_job_handle_irq() causes the reference count to increase
> >> unexpectedly. And this causes rocket_core_fini() to fail to release th=
e
> >> IOMMU group, leading to a resource leak.
> >
> >
> > While there is a leak here, I think sashiko correct in saying this chan=
ge would introduce a crash because core->iommu_group can be set to NULL bef=
ore this codepath is reached.  That might be a simple fix.
> >
> >> Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
> >
> >
> > Wrong commit mentioned here.

I fixed this one when applying.

> Thanks for you review. This is indeed a problem.

I'm sorry but I had already applied this patch to drm-misc-fixes and
pushed when I read this. I have looked at fixing just this crash, but
have decided against it because we anyway crash in drm_sched on core
unbind whenever a client is active (no need to have a job in flight),
due to the sched entities keeping a reference to the stale scheduler.

> And it has been a long time since I sent this series. :)
>
> During this time, I have seen a lot of similar work. For example, work
> similar to patch1 is here[0]. And some of the issues mentioned by
> Sashikoare also being fixed by in-flight patches like[1].

Core removal needs to be fixed as a whole: detach the open files'
entities from the scheduler that goes away, complete or cancel the job
in flight, and quiesce the job interrupt before the resources it uses
are released.

> I'm not sure whether I should slow down the submission, since it seems
> Tomeu is quite busy and hasn't gotten to some of the backlogged patches.

I'm sorry about the big backlog of patches. With Heiko and Daniel's
help I expect to get it cleared soon and be more responsive.

Regards,

Tomeu

> [0]: https://lore.kernel.org/all/20260915041152.1725014-1-vulab@iscas.ac.=
cn/
> [1]: https://lore.kernel.org/all/18667b2afdcaae217fa1038f5348ab23ed756bdc=
.1794615323.git.gahing@gahingwoo.com/
>
> --
> Best,
> Chaoyi
