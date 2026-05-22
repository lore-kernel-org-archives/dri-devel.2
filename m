Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F113CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7471310F551;
	Fri, 22 May 2026 13:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YjjKTIHe";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A940F10F551;
 Fri, 22 May 2026 13:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779455150; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IehLlswx/AfitDB+3716t3XSL/LlQmsZbSjm6lP57PTWJ7DzWXqMkT+97KHsNarAel7BylaujhVPFBbAe2iFrHg0HbMA86Vc1duUt2PRLOxOc0b+rWutE5vT4fwQ7I4LpNdsSCfeWOEzuon4hRd3PQJJ4Lt1sWc0fvc18YNlxL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779455150;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ywrhEfK4rP1qhOtmTxkDuwQOzsmmGDJqWoXLNIRX8Io=; 
 b=lvqlJNFagMnp79CLLIfvw6ULFUaQRHhlnITWtb/sa0TGKsFMIsNvPkLG8T1/92p0E3GdGyuXMIBeP71yiu2r3czAW7UVvfsIKxPNq+D+CSSlzpJ9filFj/Fm3XnIQxxDb3fcbtCXKblokTrjSm76I+QcSDmtFr9ErRbux9urd6I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779455150; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=ywrhEfK4rP1qhOtmTxkDuwQOzsmmGDJqWoXLNIRX8Io=;
 b=YjjKTIHeuU1pZ1/N7uhtKgFlXd8ojTbOnWqIr8k0xocivw1qd+QQW9NWS7NKbWWK
 5QWaIbfg8r+M5CkBHBZakRmXM4E8aexzArMnjZt4Bg/WlsrPrcwBhw16+KyPp7Vwpei
 n7YdnsakHlLEDKOTSLFos6mAYfrysHR3UgMoXSSk=
Received: by mx.zohomail.com with SMTPS id 1779455149489577.3622477463117;
 Fri, 22 May 2026 06:05:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>, Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v9 2/2] drm: Send per-connector hotplug events
Date: Fri, 22 May 2026 15:05:42 +0200
Message-ID: <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
In-Reply-To: <CAPj87rNHsa2TKMcSMHeq3M7ZfyZp0P_i3FtjxQp8Qk53UwXGLQ@mail.gmail.com>
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
 <CAPj87rNHsa2TKMcSMHeq3M7ZfyZp0P_i3FtjxQp8Qk53UwXGLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

+To: Simona Vetter, who wrote two of the commits relevant to this question.

On Thursday, 21 May 2026 17:00:17 Central European Summer Time Daniel Stone wrote:
> Hi,
> 
> On Wed, 22 Apr 2026 at 19:24, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> > @@ -760,16 +760,12 @@ static void output_poll_execute(struct work_struct *work)
> >         struct drm_connector *connector;
> >         struct drm_connector_list_iter conn_iter;
> >         enum drm_connector_status old_status;
> > -       bool repoll = false, changed;
> > +       bool repoll = false, changed = false;
> >         u64 old_epoch_counter;
> >
> >         if (!dev->mode_config.poll_enabled)
> >                 return;
> >
> > -       /* Pick up any changes detected by the probe functions. */
> > -       changed = dev->mode_config.delayed_event;
> > -       dev->mode_config.delayed_event = false;
> > -
> >         if (!drm_kms_helper_poll) {
> >                 if (dev->mode_config.poll_running) {
> >                         drm_kms_helper_disable_hpd(dev);
> > @@ -844,8 +841,15 @@ static void output_poll_execute(struct work_struct *work)
> >         mutex_unlock(&dev->mode_config.mutex);
> >
> >  out:
> > +       /* Pick up any changes detected by the probe functions. */
> > +       if (dev->mode_config.delayed_event) {
> 
> Not your doing, as it was just the same before, but doesn't this read
> need to be protected by the mode_config mutex?

It looks like the fuzzy meaning of the mode_config.mutex came to
bite here. It is set to true with the lock held in
drm_helper_probe_single_connector_modes(), but set to false in this
function without the lock, and always read without the lock
(drm_kms_helper_poll_enable(), reschedule_output_poll_work()). Some
of these calls happen in paths where it might be inconvenient to take
a lock this coarse.

Specifically, drm_helper_probe_single_connector_modes() has this
comment right before setting delayed_event to true:

	/*
	 * The hotplug event code might call into the fb
	 * helpers, and so expects that we do not hold any
	 * locks. Fire up the poll struct instead, it will
	 * disable itself again.
	 */

So there was a problem with accessing parts under a lock before,
so if we're reintroducing the coarse lock wherever the boolean is
accessed we might be going backwards here.

The relevant commits are:

Commit 162b6a57ac50 (drm/probe-helper: don't lose hotplug event, 2015-01-21)
Commit ed293f775493 (drm/sysfs: Send out uevent when connector->force changes, 2015-11-19)

One obvious move would be to change it to an atomic so at least we
punch through any caches, but that doesn't help if the intended
design was that it's in a consistent state with the rest of
mode_config. Though I don't think that's the case?

Kind regards,
Nicolas Frattaroli

> 
> The series is very satisfying otherwise; both patches are:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> 
> Cheers,
> Daniel
> 




