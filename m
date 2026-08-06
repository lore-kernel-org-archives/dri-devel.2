Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9050BC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7827510E0B7;
	Thu,  6 Aug 2026 17:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="h1NOLEL2";
	dkim-atps=neutral
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B996410E0B7
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:00:16 +0000 (UTC)
Message-ID: <03ebefdc-9324-47f4-adff-12b5e94b8840@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1786035614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkIgPRKZrNMDtQHsZmMZ+wAcfVEh2PjQ1HO2Xs2ueYg=;
 b=h1NOLEL2fjo55DwEtk58Gr+zSabHMozJwbA+HXQ0Zx+FfKgbz/rjkVpk7oQ62DiFqM4Qe/
 +TjTryDzyBm7nsQJJOOiGw7DMwLiy7Nx7FT5SCld8QQahArd7tWnKXtwUxSJlShD/zkoaX
 ZDPp9dkeapKHp/v/VZM11TUIvKr2+9U=
Date: Fri, 7 Aug 2026 00:59:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 9/9] drm/debugfs: hold device reference for the
 lifetime of open files
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>,
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-9-aea19eccb996@linux.dev>
 <DKFI3UD0X731.1X9513GWW3LT7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <DKFI3UD0X731.1X9513GWW3LT7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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


On 8/4/26 01:56, Danilo Krummrich wrote:
> On Thu Jul 30, 2026 at 7:05 PM CEST, Alvin Sun wrote:
>> Hold a device reference (via drm_dev_get/put) across the lifetime of open
>> debugfs files. Prevents use-after-free when a device is unregistered while
>> a debugfs file remains open. Both drm_debugfs_open (legacy info_list)
>> and drm_debugfs_entry_open (drm_debugfs_add_file) paths are covered.
>>
>> Fixes: 1c9cacbea8805 ("drm/debugfs: create device-centered debugfs functions")
>> Fixes: 28a62277e06f9 ("drm: Convert proc files to seq_file and introduce debugfs")
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>> ---
>>   drivers/gpu/drm/drm_debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
>> index 38cf6ce387cc8..5262a708f1602 100644
>> --- a/drivers/gpu/drm/drm_debugfs.c
>> +++ b/drivers/gpu/drm/drm_debugfs.c
>> @@ -159,11 +159,28 @@ static const struct drm_debugfs_info drm_debugfs_list[] = {
>>   static int drm_debugfs_open(struct inode *inode, struct file *file)
>>   {
>>   	struct drm_info_node *node = inode->i_private;
>> +	struct drm_device *dev = node->minor->dev;
>> +	int ret;
>>   
>>   	if (!device_is_registered(node->minor->kdev))
>>   		return -ENODEV;
>>   
>> -	return single_open(file, node->info_ent->show, node);
>> +	drm_dev_get(dev);
>> +
>> +	ret = single_open(file, node->info_ent->show, node);
>> +	if (ret)
>> +		drm_dev_put(dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int drm_debugfs_release(struct inode *inode, struct file *file)
>> +{
>> +	struct drm_info_node *node =
>> +		((struct seq_file *)file->private_data)->private;
>> +
>> +	drm_dev_put(node->minor->dev);
>> +	return single_release(inode, file);
>>   }
> This isn't needed; in drm_dev_unregister() we call debugfs_remove_recursive(),
> which already waits for all in-flight file operations. The DRM device itself is
> guaranteed to be valid as long as it is registered.

Thanks for the review. Sorry for the delay — I was on vacation the last 
few days.

v3 is ready, incorporating the feedback, and I'll send it out shortly.

Best regards,
Alvin

