Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03349C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E8710E20C;
	Thu, 17 Sep 2026 11:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AxRx57Fi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7253110E20C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789646080; x=1821182080;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=vAIdKmlOq8rM8x7TTXwKSuaj2ViCkL62qRrNagWcHuc=;
 b=AxRx57FiH/FeCUav1cVvYDuKIcfGSuuFUvKiDEOpN2Afsb9dSb2/K+Ct
 g+MJRiKxCybRVnWbG/sRAWQ2mKoo99LmH+72qACAngdacPAoxB2HpIT2G
 cM/MO78gbPRY12l4b8NRTdTXU6QPQvMpJzKA//TgNrWU2ReHa6dNvTtb0
 2a4osibGA+9NX3/cFDm7xSxTB6vTB6/DOYtO1WAXQJh/1+xSZJvQwKjpH
 DXF6eMsw5yslFRyA3uGsLcep0jIQOxBYRNKOzNBv3EsnStiT+oGz4jhPo
 QWdrH2imz2uIyb61WzlanhNMmDKv4+YNDSAUUup8fB1WCPpuBw6KvuFWb g==;
X-CSE-ConnectionGUID: /kCYAej9Sv2n2jleygXLVg==
X-CSE-MsgGUID: wIq4erh4Qae6wjTatpYrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89194088"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89194088"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:54:39 -0700
X-CSE-ConnectionGUID: CIN8f1UTSt+Urk2GUf8ewQ==
X-CSE-MsgGUID: W+XTHwFiT3+X46IR9no28Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="278961452"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:54:34 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 1/2] drm: Rename struct drm_atomic_state to
 drm_atomic_commit
In-Reply-To: <c49dea95-69a7-4c74-8321-ee81f7f6fb66@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260427-drm-drm-atomic-update-v4-0-c0e713bfdf25@kernel.org>
 <20260427-drm-drm-atomic-update-v4-1-c0e713bfdf25@kernel.org>
 <c49dea95-69a7-4c74-8321-ee81f7f6fb66@redhat.com>
Date: Thu, 17 Sep 2026 14:54:31 +0300
Message-ID: <8f8a6e12fa8c0fb5485bab71749d0ac41e7b28e1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 17 Sep 2026, Thomas Huth <thuth@redhat.com> wrote:
> On 27/04/2026 09.02, Maxime Ripard wrote:
>> The KMS framework uses two slightly different definitions for the state
>> concept. For a given object (plane, CRTC, encoder, etc., so
>> drm_$OBJECT_state), the state is the entire state of that object.
>> However, at the device level, drm_atomic_state refers to a state update
>> for a limited number of objects.
>> 
>> Thus, drm_atomic_state isn't the entire device state, but only the full
>> state of some objects in that device. This has been an endless source of
>> confusion and thus bugs.
>> 
>> We can rename the drm_atomic_state structure to drm_atomic_commit to
>> make it less confusing.
>> 
>> This patch was created using:
>> 
>> rg -l drm_atomic_state | \
>> 	xargs sed -i 's/drm_atomic_state/drm_atomic_commit/g; s/drm_atomic_commit_helper/drm_atomic_state_helper/g'
>> mv drivers/gpu/drm/tests/drm_atomic_state_test.c drivers/gpu/drm/tests/drm_atomic_commit_test.c
>> 
>> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>> ---
> ...
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 41c57063f3b4..4ffa057e2784 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
> ...
>> @@ -1764,16 +1764,16 @@ EXPORT_SYMBOL(drm_atomic_check_only);
>>    * Note that this function can return -EDEADLK if the driver needed to acquire
>>    * more locks but encountered a deadlock. The caller must then do the usual w/w
>>    * backoff dance and restart. All other errors are fatal.
>>    *
>>    * This function will take its own reference on @state.
>> - * Callers should always release their reference with drm_atomic_state_put().
>> + * Callers should always release their reference with drm_atomic_commit_put().
>>    *
>>    * Returns:
>>    * 0 on success, negative error code on failure.
>>    */
>> -int drm_atomic_commit(struct drm_atomic_state *state)
>> +int drm_atomic_commit(struct drm_atomic_commit *state)
> This causes now warnings when running "make htmldocs" :
>
> .../Documentation/gpu/drm-kms:308: .../drivers/gpu/drm/drm_atomic.c:1841: 
> WARNING: Duplicate C declaration, also defined at gpu/drm-kms:408.
> Declaration is '.. c:function:: int drm_atomic_commit (struct 
> drm_atomic_commit *state)'. [duplicate_declaration.c]
>
> Should the function maybe be renamed now?

No. It's a long-standing limitation in Sphinx that it doesn't support
the namespaces C has for functions and types. The workaround is to wrap
one or the other in an explicit Sphinx namespace in the .rst file.

BR,
Jani.


-- 
Jani Nikula, Intel
