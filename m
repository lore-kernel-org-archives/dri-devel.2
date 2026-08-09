Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC39C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E226810E161;
	Sun,  9 Aug 2026 15:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TyPBNHt3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B0D10E161
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 15:30:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B5F0412F0;
 Sun,  9 Aug 2026 15:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A3B1F000E9;
 Sun,  9 Aug 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786289456;
 bh=LJcax5g21osnPIo6IVBehWxfRbhxLzam5MlmrU5BhrQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TyPBNHt3H1UzB2NMJOW69Cvhsrs1k04u0XEREE5ci46+L4uZLB5SJPjd6eOZmrCbb
 g53oNddKQO73a/7W6QgsemrQQw2cxI2t/E3pLvMAZlfRrCIDMgbveTEIaS1eLPKi9N
 /FnNLzHzRXCizBTa7EZSHZjdXYcBxbrJRcm4KDqsD1nd2BUQx77D74lIPJ4SRDwT75
 fcK98xN/7Ui8m+xxh4FV6OuURJT7mN7lHR0onQuh/UVg11ZonFwIoVyukF72mY0F5b
 vHiYNHesQshgFV80TjOmv4lWGaciP/1nOgMRcnzPEty42q6eMdKqRtKvmY1RZKAeIZ
 Roml+oyPYlglA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] drm/amdgpu/ras: Fix delayed work cancellation
 order during teardown
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809144451.35431-5-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
 <20260809144451.35431-5-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:30:55 +0000
Message-Id: <20260809153056.43A3B1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race in sysfs/debugfs handlers can lead to a NULL pointer=
 dereference because `con->eh_data` is freed in `amdgpu_ras_recovery_fini()=
` before the sysfs and debugfs interfaces are removed.
- [High] The delayed work `ras_counte_delay_work` can iterate over the `con=
->head` list while it is being concurrently modified without locks by `amdg=
pu_ras_disable_all_features()`.
- [High] `amdgpu_ras_critical_region_init()` is incorrectly called inside t=
he teardown function `amdgpu_ras_recovery_fini()`, rendering the feature no=
n-functional and needlessly allocating memory that is immediately freed.
- [High] The MCA notifier is unregistered at the end of `amdgpu_ras_recover=
y_fini`, after locks are destroyed and data is freed, allowing use-after-fr=
ee and locking violations.
--

--- Patch [4]: [PATCH v5 4/4] drm/amdgpu/ras: Fix delayed work cancellation=
 order during teardown ---
commit 1c0d53c82e9e39018aa03ebc14a76ad3fb030607
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/ras: Fix delayed work cancellation order during teardown

In amdgpu_ras_recovery_fini(), mutex_destroy(&con->page_rsv_lock) was
called prior to cancel_work_sync(&con->recovery_work) and
cancel_delayed_work_sync(&con->page_retirement_dwork).

If pending work ran during teardown, it could attempt to acquire
page_rsv_lock after its destruction, leading to a locking violation and
potential use-after-free.

Fix this by moving cancel_work_sync(&con->recovery_work) and
cancel_delayed_work_sync(&con->page_retirement_dwork) before
mutex_destroy(&con->page_rsv_lock), ensuring both work items are
synchronously canceled while the lock remains intact.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 764cd49504083..1d6b4300d80aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3994,15 +3994,14 @@ static int amdgpu_ras_recovery_fini(struct amdgpu=
_device *adev)
>  	if (con->page_retirement_thread)
>  		kthread_stop(con->page_retirement_thread);
> =20
> +	cancel_work_sync(&con->recovery_work);
> +	cancel_delayed_work_sync(&con->page_retirement_dwork);
> +
>  	atomic_set(&con->page_retirement_req_cnt, 0);
>  	atomic_set(&con->poison_creation_count, 0);
> =20
>  	mutex_destroy(&con->page_rsv_lock);
> =20
> -	cancel_work_sync(&con->recovery_work);
> -
> -	cancel_delayed_work_sync(&con->page_retirement_dwork);
> -
>  	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
> =20
>  	mutex_lock(&con->recovery_lock);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference during driver unload?

amdgpu_ras_recovery_fini() sets con->eh_data to NULL and frees it just after
this lock is acquired. However, sysfs interfaces are not removed until
amdgpu_ras_fs_fini() is called later.

If a concurrent read in amdgpu_ras_badpages_read() checks con->eh_data outs=
ide
the lock, blocks on recovery_lock, and resumes after the teardown function =
has
freed it:

amdgpu_ras_badpages_read() {
        ...
        mutex_lock(&con->recovery_lock);
        data =3D con->eh_data;
        if (start < data->count) {
        ...
}

It will dereference the now-NULL con->eh_data when evaluating
start < data->count.


[Severity: High]
This is a pre-existing issue, but does the unregistration of the MCA notifi=
er
happen too late?

Right after this diff context, amdgpu_ras_recovery_fini() unregisters the M=
CA
notifier via amdgpu_unregister_bad_pages_mca_notifier(). This happens after
con->page_rsv_lock is destroyed and con->eh_data is freed.

If a hardware Machine Check Exception (MCE) occurs during this window,
amdgpu_bad_page_notifier() executes and calls amdgpu_ras_add_bad_pages(),
which attempts to acquire the already-destroyed con->page_rsv_lock in
amdgpu_ras_reserve_page():

amdgpu_ras_reserve_page() {
        ...
        mutex_lock(&con->page_rsv_lock);
        ...
}


[Severity: High]
This isn't a bug introduced by this patch, but is it intentional that
amdgpu_ras_critical_region_init() is called during teardown?

Just after the diff context in amdgpu_ras_recovery_fini(), we have:

        amdgpu_ras_critical_region_init(adev);
#ifdef CONFIG_X86_MCE_AMD
        amdgpu_unregister_bad_pages_mca_notifier(adev);
#endif

This function allocates memory for a critical region and adds it to
con->critical_region_head. Because it is called during teardown, the critic=
al
region list remains empty during normal operation, causing
amdgpu_ras_check_critical_address() to always return false. When the driver
unloads, the memory is pointlessly allocated and then freed shortly after.


[Severity: High]
This is a pre-existing issue, but could ras_counte_delay_work cause a
use-after-free or list corruption during driver teardown?

During teardown, amdgpu_ras_disable_all_features() locklessly iterates over
con->head using list_for_each_entry_safe() and removes nodes.

However, ras_counte_delay_work is not synchronously canceled until after th=
is
occurs in amdgpu_ras_fini(). If the delayed work executes concurrently, it =
calls
amdgpu_ras_query_error_count(), which locklessly iterates over con->head:

amdgpu_ras_query_error_count() {
        ...
        list_for_each_entry(obj, &con->head, node) {
        ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809144451.3543=
1-1-sreekuttan2156239@gmail.com?part=3D4
