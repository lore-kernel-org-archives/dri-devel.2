Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF126606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MuP/Ro94
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1910E65F;
	Mon, 19 Oct 2026 21:33:30 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C41E10E65F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:33:23 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-35ca5244753so305821eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445603; cv=none;
 d=google.com; s=arc-20260327;
 b=IqSelvsYYPr04WarJ7o7+aQEm7LSo94gLlz+sjt2f3PyLECkUki16Tjh6/m3eOLNQL
 YLO6bCW6d2YgKKeH/QoW4D4sg4D1xuzb7sRFxQBIBPULa18cglRsfDsJKn+OdYDoeqjs
 guy86qNsM40Dz6ZWBsVzb2HVOeDHlgO5v2sDtLEoN8CEq/nqWL5ySNx/Pky+pKu1W2N9
 yuNiu2mpTabKsfQ1S2LeWfjO1UyKrxfNBYTpt9RlJRVkEsloD5wcBOtDRkLDooz6CAFl
 R7g+YkCACRqZtgd4k1ANnLivnR1iosYL5UKnhTHKnFCSAghjiVW6STFzSSlyEA3ZQkar
 Sq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 fh=x9V7YQq7IbiPW0z9FwMso9YxxWSQge9NR+PdwLXWIAE=;
 b=qToxi8BqVfvWZMjo2e0//w1JNSoZhc+5+zW33eW4qbDUOLVwr1IWToqBOFqpACbrE1
 O1dchJtoHTVCECker5BnLkYaX6b/WZPrknBCa4zhFJLSICbgUdrGMyEwlO6407/8TZtW
 CZdrwhVC1zERHyZOWiywaTZuLHwDoxS0bXLQc2FrTGzGYI6iaXn2Ko3fGAinalg8Z3/N
 njwNWegjDOR0286iVGfg1SRTZXuCIgOSmutfRd/MYif9oHnGfZrkRnX9FQVcWFZMCGhO
 P8hWy7Fq552f5yKGjkM9dBidNa/i8CAcRebkx4zHRFOAaLFnJ//sJQCGJEL9wKRmLKQp
 IxvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792445603; x=1793050403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 b=MuP/Ro94aSNRREI0ASAM9ZO9rftym+kndRJvaPffFF6yiJtEVouMN3MPUxuTvWcTUU
 gaq+yulYrQXRqOqQWrUY3bQGWIjgCTBPunsJ2P2NnU9onGmD90/v5mF66hejlvO+ID8s
 ESSM2LERJ8OenAUP7e1ZgLdjv5s4wo13AvewyasWW8UjXiHBSHmwq+sPtPcQPG+iAWHc
 Z0Pwv2K6bXBKnUFhxS7cIfIXfXyI+qdvZ4sKsIkwfSA+pceKl1FiIDohm9NydglcDoRN
 D3AbgclC/KfCdfXwTv9lftPWvlv4Czrhb/J2sxjFseS32gmfFI0Ar/DAA4tcz5a3PvdM
 NPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445603; x=1793050403;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQlCl9dWOqNQIRweq291SZTEueEEhdE4wMGJJ0+9RY8=;
 b=NsehTM+v/BrNNS1QPZUp7tXziYc7iU1ru1WJqu3emvoHUqeUpgVuyQKr6Y1/DkG2Xf
 piO7ZYGynRr93KM+mNtSG3nUfyYbjkZRHpj0w/ZHpko7UNExPm2RpXnteXwtnGeOtawl
 7zinien7WUZyv8dv8fWLQz7BxudU3MTFA60lUXAkgL/qwH7NmM0cSL7l2zREQjtVmIfQ
 gE6tIDTxB+ySy9AhQXGRE4wqLKNxviWepCDFEFaW5U3GARE/Dc2eDqX1F4RshwlMVMjr
 26zH7J+TBPSbPfSsOLik5KWA93CFzEtH+MF8Cc74x+jSgPlyt2M6ip96HK2T/XuUxvfI
 DvwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2tXlDaO4tqIAtmC28ZmV2gt6kQebxsRHh8AUdh13QboUge6EvQCb7gKewx4/T/Nrx2tSyi/A6k/c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlfNpUi8PZgN3LrRwbYS2FtmncZpSx33xmOT6QdwJyWLWJmNlt
 VM4vfTFme9Zd9jWbE/yePjCRSDFcwktSuNZOV++Fbrhsm4y8VlqrLRX+xHOVIqQcELWtSTatVqG
 LJdJMIBsiXCf9XrbKpbKlqMIyvMbK4lI=
X-Gm-Gg: AYBFou050A/PpChweOf/MLjcc7TnuZAPIbozZbYZWMAemUQIAAX4UV9/J4TLWGc7K8d
 KEQh3OTORImy3FMJjK7DQ1Qi72h+VegfELWFMhKgwJpcMJE1n0geF3WrIBqXxymXEcpsFWCIVOB
 3SOTnn8hXumgYWpN8t2S9RHxjI/bp2XFPRliZzmK4/YJtouB/i37w905V4ZlPgUy6xCMnTInFFX
 WtQX+9QiYIkjxldXYQvA74ahkDWSIJBrC9zbsx164/Ot7tSmhvNWouRthB95vW1vnlzxMNDsoF5
 E4JI2AYIQOS+vysu/vzqtOvNr+c6JCxKFr+TxMe5neA8r/yRtqXNjnW3X0fjUNqjzA5I9Df+G53
 67Oi2wBbIyNe7AIWmyn6dASx8ZGBBHWPZTcYkwoAg2g==
X-Received: by 2002:a05:7023:a5c:10b0:183:d275:cf76 with SMTP id
 a92af1059eb24-18511adbd46mr19516085c88.2.1792445602643; Mon, 19 Oct 2026
 14:33:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016141504.2794541-1-yaojiale02@163.com>
In-Reply-To: <20261016141504.2794541-1-yaojiale02@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 17:33:10 -0400
X-Gm-Features: AclHuK_Me7TacYeo4mJbcJaHVL-oGV4AZjveGBSsw30ka30ykjikfca5QZHE9gM
Message-ID: <CADnq5_OneLPoTnDtowe2zVfLwN3_NZ3uFefNOw5itRKi6HivvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: validate SRAT subtables before parsing
To: Jiale Yao <yaojiale02@163.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 2:26=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> The KFD SRAT walker reads the first subtable length without checking
> that a header is present and trusts subsequent lengths when accessing
> CPU and generic affinity records. Invalid firmware lengths can therefore
> cause out-of-bounds reads.
>
> Validate the table header, every generic subtable range, and each
> supported typed record before reading its fields.
>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 35 ++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index 6e0df685503d..32d7573dffc9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2056,27 +2056,33 @@ static void kfd_find_numa_node_in_srat(struct kfd=
_node *kdev)
>                 return;
>         }
>
> +       if (table_header->length < sizeof(struct acpi_table_srat))
> +               goto invalid_srat;
> +
>         table_end =3D (unsigned long)table_header + table_header->length;
>
>         /* Parse all entries looking for a match. */
>         sub_header =3D (struct acpi_subtable_header *)
>                         ((unsigned long)table_header +
>                         sizeof(struct acpi_table_srat));
> -       subtable_len =3D sub_header->length;
>
> -       while (((unsigned long)sub_header) + subtable_len  < table_end) {
> -               /*
> -                * If length is 0, break from this loop to avoid
> -                * infinite loop.
> -                */
> -               if (subtable_len =3D=3D 0) {
> -                       pr_err("SRAT invalid zero length\n");
> -                       break;
> -               }
> +       while ((unsigned long)sub_header < table_end) {
> +               unsigned long start =3D (unsigned long)sub_header;
> +
> +               if (table_end - start < sizeof(*sub_header))
> +                       goto invalid_srat;
> +
> +               subtable_len =3D sub_header->length;
> +               if (subtable_len < sizeof(*sub_header) ||
> +                   subtable_len > table_end - start)
> +                       goto invalid_srat;
>
>                 switch (sub_header->type) {
>                 case ACPI_SRAT_TYPE_CPU_AFFINITY:
>                         cpu =3D (struct acpi_srat_cpu_affinity *)sub_head=
er;
> +                       if (subtable_len < sizeof(*cpu))
> +                               goto invalid_srat;
> +
>                         pxm =3D *((u32 *)cpu->proximity_domain_hi) << 8 |
>                                         cpu->proximity_domain_lo;
>                         if (pxm > max_pxm)
> @@ -2084,6 +2090,9 @@ static void kfd_find_numa_node_in_srat(struct kfd_n=
ode *kdev)
>                         break;
>                 case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
>                         gpu =3D (struct acpi_srat_generic_affinity *)sub_=
header;
> +                       if (subtable_len < sizeof(*gpu))
> +                               goto invalid_srat;
> +
>                         bdf =3D *((u16 *)(&gpu->device_handle[0])) << 16 =
|
>                                         *((u16 *)(&gpu->device_handle[2])=
);
>                         if (bdf =3D=3D pci_id) {
> @@ -2100,9 +2109,13 @@ static void kfd_find_numa_node_in_srat(struct kfd_=
node *kdev)
>
>                 sub_header =3D (struct acpi_subtable_header *)
>                                 ((unsigned long)sub_header + subtable_len=
);
> -               subtable_len =3D sub_header->length;
>         }
>
> +       goto out;
> +
> +invalid_srat:
> +       pr_err("SRAT contains an invalid subtable\n");
> +out:
>         acpi_put_table(table_header);
>
>         /* Workaround bad cpu-gpu binding case */
> --
> 2.34.1
>
