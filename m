Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58FCF34C47
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D5410E2C1;
	Mon, 13 Apr 2026 11:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PdSFP9OH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FD310E0F7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:56:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D0106111B;
 Mon, 13 Apr 2026 11:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B122AC116C6;
 Mon, 13 Apr 2026 11:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776081359;
 bh=+GrvEr4Ad/5iehJEwtnzkxjU7cJjjLPujjrKRT9iKuQ=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=PdSFP9OHPuMyUTExVEMoYO0jLzoV97SAvBwGDvufOUAeY5N0ZW9ONXNgTPYfVRPvY
 MhQR+Odz9qfSSpz3Cvu3LpBBd0js1FyXWIwFSQdmmqjyKjvhWLrHxMl6KYIKb2pvZS
 IMmBVyUcF5I/Rer7PuTR4ybK7mOyT5NQuY+k3Jrc=
Subject: Patch "Revert "drm: Fix use-after-free on framebuffers and property
 blobs when calling drm_dev_unplug"" has been added to the 6.6-stable tree
To: dev@lankhorst.se, dri-devel@lists.freedesktop.org,
 e61e64c796ccfb17ae673331a3df4b877bf42d82.camel@linux.intel.com,
 gregkh@linuxfoundation.org, linux@leemhuis.info, linux@roeck-us.net,
 matt.fagnani@bell.net, regressions@leemhuis.info, regressions@lists.linux.dev,
 sashal@kernel.org, simona.vetter@ffwll.ch, thomas.hellstrom@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 13:55:46 +0200
In-Reply-To: <20260413080333.3079490-1-linux@leemhuis.info>
Message-ID: <2026041346-jawless-rift-e8ee@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    Revert "drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug"

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-drm-fix-use-after-free-on-framebuffers-and-property-blobs-when-calling-drm_dev_unplug.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From linux@leemhuis.info Mon Apr 13 10:06:33 2026
From: Thorsten Leemhuis <linux@leemhuis.info>
Date: Mon, 13 Apr 2026 10:03:33 +0200
Subject: Revert "drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug"
To: regressions@leemhuis.info
Cc: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org, matt.fagnani@bell.net, regressions@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org, "Maarten Lankhorst" <dev@lankhorst.se>, "Thomas Hellström" <thomas.hellstrom@linux.intel.com>, "Guenter Roeck" <linux@roeck-us.net>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Thorsten Leemhuis" <linux@leemhuis.info>
Message-ID: <20260413080333.3079490-1-linux@leemhuis.info>

From: Maarten Lankhorst <dev@lankhorst.se>

commit 45ebe43ea00d6b9f5b3e0db9c35b8ca2a96b7e70 upstream.

This reverts commit 6bee098b91417654703e17eb5c1822c6dfd0c01d.

Den 2026-03-25 kl. 22:11, skrev Simona Vetter:
> On Wed, Mar 25, 2026 at 10:26:40AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Mar 13, 2026 at 04:17:27PM +0100, Maarten Lankhorst wrote:
>>> When trying to do a rather aggressive test of igt's "xe_module_load
>>> --r reload" with a full desktop environment and game running I noticed
>>> a few OOPSes when dereferencing freed pointers, related to
>>> framebuffers and property blobs after the compositor exits.
>>>
>>> Solve this by guarding the freeing in drm_file with drm_dev_enter/exit,
>>> and immediately put the references from struct drm_file objects during
>>> drm_dev_unplug().
>>>
>>
>> With this patch in v6.18.20, I get the warning backtraces below.
>> The backtraces are gone with the patch reverted.
>
> Yeah, this needs to be reverted, reasoning below. Maarten, can you please
> take care of that and feed the revert through the usual channels? I don't
> think it's critical enough that we need to fast-track this into drm.git
> directly.
>
> Quoting the patch here again:
>
>>  drivers/gpu/drm/drm_file.c| 5 ++++-
>>  drivers/gpu/drm/drm_mode_config.c | 9 ++++++---
>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index ec820686b3021..f52141f842a1f 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -233,6 +233,7 @@ static void drm_events_release(struct drm_file *file_priv)
>>  void drm_file_free(struct drm_file *file)
>>  {
>>  struct drm_device *dev;
>> +int idx;
>>
>>  if (!file)
>>  return;
>> @@ -249,9 +250,11 @@ void drm_file_free(struct drm_file *file)
>>
>>  drm_events_release(file);
>>
>> -if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>> +if (drm_core_check_feature(dev, DRIVER_MODESET) &&
>> +drm_dev_enter(dev, &idx)) {
>
> This is misplaced for two reasons:
>
> - Even if we'd want to guarantee that we hold a drm_dev_enter/exit
>   reference during framebuffer teardown, we'd need to do this
>   _consistently over all callsites. Not ad-hoc in just one place that a
>   testcase hits. This also means kerneldoc updates of the relevant hooks
>   and at least a bunch of acks from other driver people to document the
>   consensus.
>
> - More importantly, this is driver responsibilities in general unless we
>   have extremely good reasons to the contrary. Which means this must be
>   placed in xe.
>
>>  drm_fb_release(file);
>>  drm_property_destroy_user_blobs(dev, file);
>> +drm_dev_exit(idx);
>>  }
>>
>>  if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index 84ae8a23a3678..e349418978f79 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -583,10 +583,13 @@ void drm_mode_config_cleanup(struct drm_device *dev)
>>   */
>>  WARN_ON(!list_empty(&dev->mode_config.fb_list));
>>  list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
>> -struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
>> +if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > 1) {
>> +struct drm_printer p = drm_dbg_printer(dev, DRM_UT_KMS, "[leaked fb]");
>
> This is also wrong:
>
> - Firstly, it's a completely independent bug, we do not smash two bugfixes
>   into one patch.
>
> - Secondly, it's again a driver bug: drm_mode_cleanup must be called when
>   the last drm_device reference disappears (hence the existence of
>   drmm_mode_config_init), not when the driver gets unbound. The fact that
>   this shows up in a callchain from a devres cleanup means the intel
>   driver gets this wrong (like almost everyone else because historically
>   we didn't know better).
>
>   If we don't follow this rule, then we get races with this code here
>   running concurrently with drm_file fb cleanups, which just does not
>   work. Review pointed that out, but then shrugged it off with a confused
>   explanation:
>
>   https://lore.kernel.org/all/e61e64c796ccfb17ae673331a3df4b877bf42d82.camel@linux.intel.com/
>
>   Yes this also means a lot of the other drm_device teardown that drivers
>   do happens way too early. There is a massive can of worms here of a
>   magnitude that most likely is much, much bigger than what you can
>   backport to stable kernels. Hotunplug is _hard_.

Back to the drawing board, and fixing it in the intel display driver
instead.

Cc: Thomas HellstrÃ¶m <thomas.hellstrom@linux.intel.com>
Fixes: 6bee098b9141 ("drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Link: https://patch.msgid.link/20260326082217.39941-2-dev@lankhorst.se
[ Thorsten: adjust to the v6.6.y/v6.6.y backports of 6bee098b9141 ]
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_file.c        |    5 +----
 drivers/gpu/drm/drm_mode_config.c |    9 +++------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -243,7 +243,6 @@ static void drm_events_release(struct dr
 void drm_file_free(struct drm_file *file)
 {
 	struct drm_device *dev;
-	int idx;
 
 	if (!file)
 		return;
@@ -269,11 +268,9 @@ void drm_file_free(struct drm_file *file
 
 	drm_events_release(file);
 
-	if (drm_core_check_feature(dev, DRIVER_MODESET) &&
-	    drm_dev_enter(dev, &idx)) {
+	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
-		drm_dev_exit(idx);
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -546,13 +546,10 @@ void drm_mode_config_cleanup(struct drm_
 	 */
 	WARN_ON(!list_empty(&dev->mode_config.fb_list));
 	list_for_each_entry_safe(fb, fbt, &dev->mode_config.fb_list, head) {
-		if (list_empty(&fb->filp_head) || drm_framebuffer_read_refcount(fb) > 1) {
-			struct drm_printer p = drm_debug_printer("[leaked fb]");
+		struct drm_printer p = drm_debug_printer("[leaked fb]");
 
-			drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
-			drm_framebuffer_print_info(&p, 1, fb);
-		}
-		list_del_init(&fb->filp_head);
+		drm_printf(&p, "framebuffer[%u]:\n", fb->base.id);
+		drm_framebuffer_print_info(&p, 1, fb);
 		drm_framebuffer_free(&fb->base.refcount);
 	}
 


Patches currently in stable-queue which might be from linux@leemhuis.info are

queue-6.6/revert-drm-fix-use-after-free-on-framebuffers-and-property-blobs-when-calling-drm_dev_unplug.patch
