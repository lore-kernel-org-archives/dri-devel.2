Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04996C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C6C10E12F;
	Tue,  8 Sep 2026 16:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMuht812";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0A210ECF0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:04:11 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c656140de2so85061e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 09:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883450; cv=none;
 d=google.com; s=arc-20260327;
 b=rpFl1vEOmAsjo24UTfmCH9GTXMm/K3KapPpde3mMZwOjdLL2CjH7mA6yYGPxUrX0YV
 cWRGPHSGIrVBm09+K8ZKkyqEUSVxL//COA+zcQVfaUprhUeREHTPj+FyifAo7r0INVdV
 r4vXewXTSSXqKJiDXNauz49ZgkgcKk9EWuYYxq/nEhv44kBtyACziCcSA6nuk1/scjJ/
 BG1jxHljaEgGmo9hr6wcP5UwmXmL6F36czLF/QSJLnYhoasKGzxzEuglHyh9wcJZyXEI
 88v75HMbt0AgE+8mvYK8+8iqb4hQRiZyBtFRqIsll5pUpXGfwKEsLyP9xUhS8nxxLDZ+
 CsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 fh=VHrvo4c8od7HF6fe1jb/NjrMGhhDOLnbYx0QMiN0jYM=;
 b=nB1fwXVCFQ7k7mJlDcZcun1oLqxDKS0ykmgOhA2HV0XnOTgCIWs2T1NP7dYRdHqJku
 GFaD0OB19tLbSWi0Lh7XYWtfHzEdwjxeTmE12cBWQWNV4PboB7Jn/63FzMgsQ/KYND/8
 tFSJwNjEyuA/KmAkRvqaCfDgg+NNKRz2spptgwvWeoz302NfkvoAbP0tqXqu7Z5qo+w4
 e4Ej5qcFpiAPWFtPfey2jx1VR4/H+wA8Q8lScFZnuetZgGin7wsGv28q1WYhmrVkdV5G
 PeEesuoEsLPRpgIre64cB19pocNx0fIww8096sMoFUDflJ1T3RVK+IUqwxTEj4xMX8Qp
 a6hQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788883450; x=1789488250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 b=hMuht812HX7O7V+DELib/fwsrHKBaKblvJ6kfR5hguA41VHLyjq8zZva4+eJVzpZ0n
 yzMom9bKMYZHVS9186oI7Gb6POnDWqRwiMMbwJ0V7NFywDxd8C33DadZzMrB6skBbWfJ
 5yn5tqbu91CXHpk1jDbH2x2MvmOkD/j1zOUV7Ap2w3FoJ+b1kvNqeS+ezhcnZtqop+CS
 C4fdTvburtOcYc1ZbETuuiu1TaT7LwEQg+tOCf1roesaPfth7n9vK8lun93hJDX11mco
 v85qHgVCvVDt3rUBOiT5EGqJZiwxO6jimIghfsMUeHK6RkhTsv53QeSFRh0u2zFabvrB
 AUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788883450; x=1789488250;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nt0kh0XYrPSHGJubgJUC0bfBx9LloKYXdOD5FMiKas0=;
 b=B24o4AStAW7dFfpRMqT3Arq8vFvTw3XSTh8Hz/Qrcj/DFmDqI3HLoB/khT3BQluPuk
 6kX3EpG26JWba6gwlxJ37VHCNN3As1W0Xs6P3J5ZbbzZiJCGLYQ518sBUsLIJoeCprwQ
 9r5O8yeBjNIAir4s3I3qhHR5Bl4h2q9RmHfx9QC/Jo6yTNMXcnerguSZ5GsbVeblHSgk
 38O4uuGS2jAWOty3ii2RYZPs8EWP6yVTM7EGplSzlZXjMuNUK6/7WqsFschF2eDouCzJ
 Z/R/5Wdbaog8fopX2VP96YDbjK7ksEUgX7YIj/2O4Lns1OR84o4DiEVNtB6CC4IJyTHA
 QsSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKMO5UZJJ3uC6LR6V5T3qP7zeGWexDUNiz+F4I4y+1G2yA2tL8r60ZK0EwKzaJnyLjmOpoGkho0MM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7WY45S442ZQnppt1mjwdAt4/D0JLdi0fpjnD/6eWdYS2/ty5n
 PNGtiSfeTQaqkpWO7/dHn14pVbXbGxubS11Zrv5W8to/07dWXThEW2HRcjCIzXhSl2TF/8GPK0Q
 gqx8e+Z/VkhL9pB7Y21Tt+fy1R/onNrw=
X-Gm-Gg: AYBFou0NIbgAUyvLG5EQ1G9911VLoEjSTIR6vrOntO6D3Oqw2Uy0oyyHJKe9fq7AMj/
 Rnt/si5pBFXL0OjrGPzY/pjJpWQJRMDQEmm9dkFunslPZSBIu4o/Brj2H5pxxq40g6X80tCRd4N
 sAcIaSzq/1pLoCrikFVfobg8cLWvRHAwN0xzaErt5M1NE+s2LcdK8qo+yxnQqKWG6BPchUrWosg
 WWXp8Q5SIQkG4vMScMh1Ek/4RjO1M0WuKczUbZJ85Tx+Hpd3QMHZLAspHEGgOfG09E9TiN+AH8C
 01x1IyuFj0ZeBM8r5iY3q6mlDcnxdv0VXP869M4MnekiC8rj4e8wsTXDEKNbMSfQOH4tvivZBro
 RG2OuAgvhqG6Hq47VyftreBaztoGsJPw=
X-Received: by 2002:a05:6122:a5c7:10b0:5c1:24b6:a1e0 with SMTP id
 71dfb90a1353d-5c7fbaf3b05mr2679642e0c.3.1788883450339; Tue, 08 Sep 2026
 09:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
 <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
In-Reply-To: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Sep 2026 12:03:57 -0400
X-Gm-Features: AcwNN1UGWQ08V1C6NZZQaio8lehal8RQn4GKIdJFwvOdWZL0ItwTZuEEeLAGaiw
Message-ID: <CADnq5_PjN8X9V0PQ=no39NCAGM9Hp1JezOuKNpHqwo1=WfsPQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
To: Klara Modin <klarasmodin@gmail.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Mukul Joshi <mukul.joshi@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, Sep 7, 2026 at 3:25=E2=80=AFAM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
> On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
> > On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
> > > On 8/31/26 20:33, Alex Deucher wrote:
> > > > From: Mukul Joshi <mukul.joshi@amd.com>
> > > > ...
> > > ...
> > >
> > > > > error[E0063]: missing field `handle_free` in initializer of `drm_=
gem_object_funcs`
> > > > >    --> rust/kernel/drm/gem/mod.rs:265:58
> > > > >     |
> > > > > 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs =3D =
bindings::drm_gem_object_funcs {
> > > > >     |                                                          ^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
> > > > >
> > > > > error: aborting due to 1 previous error
> > > > >
> > > > > For more information about this error, try `rustc --explain E0063=
`.
> > > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
> > > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-nex=
t-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:=
1442: prepare] Error 2
> > > > > make: *** [Makefile:256: __sub-make] Error 2
> > > """
> > > Full log:
> > > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/ne=
xt/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
> > >
> > > Reverting this change and 2/3 from this set fixed the problem for me.
>
> That leaves only the documentation without the feature so might as well
> drop 3/3 too in that case?
>
> Otherwise, the following also fixes it for me:
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e1ebad77ebe2..847e0ee38863 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
>
>      /// Returns the `Device` that owns this GEM object.
>

Can you send this as a proper patch?

Thanks,

Alex

> >
> > Verified.
> >
> > Thanks
> >  Manuel
> > >
> > > Ciao, Thorsten
> > > > ...
>
> Regards,
> Klara Modin
