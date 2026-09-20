Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A47C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 17:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9D310E0F3;
	Sun, 20 Sep 2026 17:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D58VTOm2";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3436B10E0F3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 17:25:52 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4ab201ebso1571224d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 10:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789925151; cv=none;
 d=google.com; s=arc-20260327;
 b=grLb3JTGb3qOKnrAVyoW1PRyahPPMtTKjuhOKEnnPabuKzHZW8VYXw9TtiqPDFrM4y
 c7cXAFMy8CnWEoI5SL+LAwlniUts4Qbg98w6s5DZufGPQ7ZyXJ8OUmjDcYZpkmwTF+3D
 eBbN9ToAMvdzq+hDGY+UTlw5sd83KobtEr3x02/hDuJLsr0Um8vpXnwfO/f1ybGmvnEu
 PH1qY9IRCF/3SVYSLs7/WcQJADHN6zhrHnWwUXnEKs3T+kaDAKVxIaAZtqGIOVcd4Fko
 7UCpw12gtycHoUje3OxDv5+9hy9QkvhlNm1nta8vb0/wEc1IstYRTIyhj68ixxRVAzyt
 w0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
 fh=4W39QXNjJdrTnAxRCsoXCF472mk4uaCPWsGuovnDUqs=;
 b=CJ0lITwDwH34KQ3CpMsh4UrOClth4rGeZrCURFhPtk3k9Z7lkFMGjTwVyzm19qQQEI
 odI1QPMMSyUpSFWzMd7TCH0sklMGFNnOyBhMucgX7YfNuqFDypusMGdIsY/sgXDe0LKK
 uwhH4ra9us/5aTT86jwdGYiBcdPhYuXP9p+kbplkK9PrHwUE6XEN5gBlTU0wGyBsM/Qn
 oWzuc0B01oIDde/PZ1/tnHPO0FqVrKnxX6ShDoA+i+wJcTvxDMHMTlh8Jn0H7zWVIAYp
 uGn1Zz131LoyDzO8/3KmWY9iYve61Ycf9rbF5XGTzQVYeWP667v/IL8t2GcYKn63yr/7
 myFA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789925151; x=1790529951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
 b=D58VTOm2WaSpVZvsfCMvsl4iQVGnV+ubpRX/qVhvB0YfoanJH0RSYwoBn9F8PD21Y2
 nfyRyguEv5SHvpRQcBQBiE8bbQ3sVt4XjZ1LjJrmUvO+rEUAG/ejX38PJlcJVxCivmN6
 OAiytS/nGsMf2M3KjxfBaS8wgS4bxDhIvPEnaf2SMGmfRs4GO4uR1pF48pD55wK+Q8Q1
 colc1Dg4ISuP0BQI614Y6mdLhRtXJxNf4HP7ZXd/QjI/4NCv5Y2nHegvTMibVHHDvC+7
 jwF98Gf/wKMV6eUi1qBipfW55YhTnai8IVz87YMXrQttK5edzCvpKZ2oWLjFx+8xPo69
 8aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789925151; x=1790529951;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OfbjdZ7JhnmWB3SFJinxtG8xu+EcVyQidKsmmu69Ws=;
 b=mtBedSO03zxt0Nk+i3inKnQ2agPYmCa4xXoKUqnCfH+lTTE3tV2NkPKJ3Z3pxQJC23
 tByzEYzMzxlzA1QLhh1bEYbpQHtNK7dTdtmx1WuWMhjNfqij9y2tdJmfZFrWTe/f8Lse
 /fF8olXdVwlq7XNbd8rECWfSbQoYUlaju5el2aSx36We/tUA8HO3CC+mxBFAva4PXfnv
 N+3+uu1AUiaAqnc+5W7Cy3Hjv+FV43X4pP+G67sWwouFuYdvTVsgIMtfj0Sa6WXTIaiZ
 x2saSTVuFabdHuYDLZaZ/gkHagGMNIy/gYBNPZF4A7ouUnaKNE+RtHlSWFgAuuxlA6fl
 lO0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHc9jF1HBFqdtKcystuVmjZic2EQqUD6qUscd07buH9za/rA1nS99OWTRNCAiJOifw74KVVZkeaB0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nhtkxDcWU/129zcMjJ+nRR2d3HnJ3sztdwvxx+djSPjSnNGj9X
 1gF8iqs+iHE10yN9nuW0PpC7w/dl7Lps0eNqvN2BlmETf69tT0muB65awHin9zZ/mdgmFW3rtqy
 FrJ09bOXVuq2ku66HzLMC1bV5R2RsF9e0Kw==
X-Gm-Gg: AYBFou3pQ94yGDc49PJ4xbDP7SD8Z8gf9184BMAXZkklksvH6UnNxnOJnCuKOhgkrHC
 btKQg4NOrNTDkmPokXhPzoc3neZsFxclf1g3JYG1UVZQnYJ4nGTfYDSCd8t7EjEZg8/2OOj0eJQ
 72Tsr2nEGGqm8yo4hCmx9+RECWj8Me9KRFb3bxkhv72FtkwuhxUozZWDrUVWtwYfNOHpluIU0Ft
 +QG0A+PoCN2/kFHCQjaXGwC2EL7O/EMQm68WM4GhgIInCuwKudk80I6+a4jRYbNY9erHoz+dRrj
 feoRFP+b7JXT/H0FMBvD+fwkv9VW5D+yvb0umKtNEvM9hBjb4yqMDkCMaulQI/aFYxrlutooaZ6
 F9shCWWyAw+WsBT2v84r6fyzQNt9roEToGg==
X-Received: by 2002:a05:690e:bc9:b0:66e:45c8:fc92 with SMTP id
 956f58d0204a3-6717fcac9f3mr2366498d50.23.1789925151025; Sun, 20 Sep 2026
 10:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-24-af4cf4767707@gmail.com>
 <20260916162426.BF6241F000FF@smtp.kernel.org>
In-Reply-To: <20260916162426.BF6241F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Sun, 20 Sep 2026 11:25:24 -0600
X-Gm-Features: AcwNN1U4PdC2-ak_eLI6nDpyzmI74MRgcM2U5SRdaLHhoM3APxQAdxw6Wk6ZIJ0
Message-ID: <CAJfuBxxGEYMZxChjRzG02tPM-WtVnjWM5mMCcfaJN9yX1vNTUA@mail.gmail.com>
Subject: Re: [PATCH v10 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Sep 16, 2026 at 10:24=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests: dyndbg: load-time parameters truncated due to shell=
 quoting bug
> --
>
> commit f2f3cad7addd566a67a218932463053f35d4d782
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> selftests/dyndbg: Enable FT_classmap_inheritance
>
> Exercise classmap state inheritance between supermod and submod,
> verifying that class settings and controlling parameter states propagate
> from parent classmap definitions to dependent class users upon module
> load and during runtime reconfiguration.
>
> > diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b=
/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > index 09a8dbf239dcf..51338ebc74bf8 100755
> > --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> > +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> [ ... ]
> > @@ -298,6 +299,78 @@ function FT_basic_queries {
> >      ddcmd "file $f =3D_" "$f"
> >  }
> >
> > +function FT_classmap_inheritance {
> > +    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
> > +
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # modprobe with plain-old +p & 3 class enablements
> > +    my_modprobe test_dynamic_debug \
> > +     "dyndbg=3D+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +=
pm"
>
> [Severity: Medium]
> Are these load-time parameters truncated during module load due to how th=
e
> shell handles quotes?
>

yes, Ive seen it locally.
it is the reason for comma-terminator patch later in series.
next rev adds 2nd level of quoting here,
then switches to comma-terminator once that patch is added.


> When bash evaluates and strips the double quotes before executing modprob=
e,
> modprobe constructs the kernel options string without adding quotes aroun=
d
> the parameters. The kernel's parse_args() function (using next_arg() in
> lib/cmdline.c) splits module parameters at unquoted spaces.
>
> This means it treats D2_CORE and +pf as separate unknown parameters. The
> dyndbg parsing logic executes +p but fails on the truncated class command=
,
> completely ignoring the actual class configurations.
>
> Does this defeat the test's intent to verify load-time classmap inheritan=
ce,
> allowing it to pass only because the golden hash recorded the incorrectly
> applied +p state?
>
> It appears this space-splitting flaw persists through the end of the patc=
h
> series, and the newly added FT_test_classes also replicates it.
>
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
> > +    verify_control_slice '\[test_dynamic_debug\]'
> > +
> > +    my_modprobe test_dynamic_debug_submod
> > +    verify_control_slice 'test_dynamic_debug_submod'
> > +
> > +    # fresh start, to clear all above flags (test-fn limits)
> > +    ifrmmod test_dynamic_debug_submod
> > +    ifrmmod test_dynamic_debug
> > +
> > +    # load submod, which loads supermod
> > +    my_modprobe test_dynamic_debug_submod \
> > +     "dyndbg=3D+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC=
 +pmf"
>
> [Severity: Medium]
> Does this submod load suffer from the same space-splitting issue?
>
> > +    verify_control_slice 'test_dynamic_debug'
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-=
part2-clean-v10-0-af4cf4767707@gmail.com?part=3D24
