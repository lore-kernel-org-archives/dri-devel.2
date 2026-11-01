Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE65606A32F
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzR0Q73q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6BF10EAD9;
	Sun,  1 Nov 2026 23:00:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69DA10EAD9;
 Sun,  1 Nov 2026 23:00:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 247FB605CF;
 Sun,  1 Nov 2026 23:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DD81F000C1;
 Sun,  1 Nov 2026 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574007;
 bh=ONou6x2eXFpRRnPhrtHuB/bLB9/xi2NljyjKlOM6Tno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GzR0Q73qHOoyfEEnRon0FUyK+NV/+8t8dvMNR4n8NtJLMCot9lZDz1iPKVx64zzkq
 MWa+iiHaC44ekD79oxWzoJh7oB7n5B3bohjPSt4RRUdvjIOZRusTCewkcl85NHIXnV
 qBDeAxqujIQQ7C+bQmnUi5HOG9IvE++0R7FLtH+7afVYkW3eRwA/fi9G6vl5dzjN7+
 EKU229eTHp07/+QRKwaaM3/sAY8vRr0FfUTHOoyevK/GtqWsEgivhaYgEcraOhW67X
 0FAuY+fWPkW2mT5U0V5rDbxtfpKW+lttC2sQVhYzDRF+idaHH4WtOdyxn4u4aLkWXt
 UCFelxcIRyq8g==
Message-ID: <sashiko-outbox-192747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/xe_ras: Use xe_log_info to avoid passing zero as
 error code
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261101225252.556741-1-ethantidmore06@gmail.com>
References: <20261101225252.556741-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:00:07 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/xe/xe_ras: unintended severity downgrade in handle_page_offl=
ine()
--

commit 43f2f57f0adc520b740507efd524d932280d6544
Author: Ethan Tidmore <ethantidmore06@gmail.com>

drm/xe/xe_ras: Use xe_log_info to avoid passing zero as error code

This commit replaces xe_log_err() with xe_log_info() in the case 0 branch
of handle_page_offline() in drivers/gpu/drm/xe/xe_ras.c to avoid passing
a zero return value to xe_log_err().

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 2c01c183d02b1..df157d521d640 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -346,9 +346,9 @@ static int handle_page_offline(struct xe_device *xe, =
u64 page_address, bool noti
>  	switch (ret) {
>  	case 0:
>  		action =3D XE_RAS_PAGE_ACTION_REMOVE;
> -		xe_log_err(xe, DEVICE_MEMORY, ret,
> -			   "Poison detected at physical address 0x%llx, page soft-offlined\n",
> -			   page_address);
> +		xe_log_info(xe, DEVICE_MEMORY,
> +			    "Poison detected at physical address 0x%llx, page soft-offlined\n=
",
> +			    page_address);

[Severity: Medium]
Does switching to xe_log_info() here unintentionally downgrade the severity
of a hardware memory poison event when xe_ttm_vram_handle_addr_fault()
returns 0 in handle_page_offline()?

In drivers/gpu/drm/xe/xe_log.h, xe_log_err() explicitly documents 0 as a
valid argument when no negative errno applies, and emits the log entry with
CPER_SEV_RECOVERABLE severity:

    * @err: negative errno for the failing operation, or 0 if not applicable
    ...
    * The log entry will be emitted with @CPER_SEV_RECOVERABLE severity.
    */
    #define xe_log_err(any, TAG, err, fmt, args...) \
            xe_log_comp_recoverable((any), TAG, ERR_PTR(err), 0, fmt, ##arg=
s)

Meanwhile, xe_log_info() still passes 0 to ERR_PTR() via xe_log_err_info(),
while downgrading the severity to CPER_SEV_INFORMATIONAL:

    #define xe_log_err_info(any, TAG, err, fmt, args...) \
            xe_log_comp_info((any), TAG, ERR_PTR(err), 0, fmt, ##args)
    ...
    #define xe_log_info(any, TAG, fmt, args...) \
            xe_log_err_info((any), TAG, 0, fmt, ##args)

In drivers/gpu/drm/xe/xe_log.c, log_emit_dmesg() handles ERR_PTR(0) (which =
is
NULL) in the final else branch by omitting the (%pe) output, while using
cper_sev to select pci_err() vs pci_info() and whether to include the
*ERROR* and [Hardware Error] prefixes:

    if (IS_ERR(data))
            log_dmesg_printf(pdev, cper_sev, "SIGID=3D%u %s(%pe) %s%s%s%pV",
                             sigid, sev_prefix, data, hwe_prefix,
                             loc_prefix, comp_prefix, vaf);
    else if (data && len)
            log_dmesg_printf(pdev, cper_sev, "SIGID=3D%u %s(%*phN) %s%s%s%p=
V",
                             sigid, sev_prefix, (int)len, data, hwe_prefix,
                             loc_prefix, comp_prefix, vaf);
    else
            log_dmesg_printf(pdev, cper_sev, "SIGID=3D%u %s%s%s%s%pV",
                             sigid, sev_prefix, hwe_prefix,
                             loc_prefix, comp_prefix, vaf);

In addition, send_page_offline_cmd() in drivers/gpu/drm/xe/xe_ras.c, which
runs immediately after this switch on the case 0 path, already passes a
literal 0 to xe_log_err():

    if (action =3D=3D XE_RAS_PAGE_ACTION_OFFLINE)
            xe_log_err(xe, DEVICE_MEMORY, 0, "Requesting firmware to offlin=
e page 0x%llx\n",
                       page_address);
    else
            xe_log_err(xe, DEVICE_MEMORY, 0, "Requesting firmware to remove=
 page 0x%llx from queue\n",
                       page_address);

If this change was intended to silence a static checker warning on passing
the variable ret to ERR_PTR(ret) when ret is known to be 0, would passing a
literal 0 to xe_log_err() instead preserve the CPER_SEV_RECOVERABLE severit=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101225252.5567=
41-1-ethantidmore06@gmail.com?part=3D1
