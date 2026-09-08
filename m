Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D4C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2AD10E11A;
	Tue,  8 Sep 2026 14:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="BLHTkZWw";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08B810E11A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:25:18 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=lB6ADInmwINs9qRDDS5D7SYp9+41Judvy+epNhkXocs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788877517; v=1; x=1789482317;
 b=BLHTkZWwAZnMFO/Ffsr6aTHz9ppgqAFccjizxrvZ8R0VjfJOVpULT+KUAGGUwRN0Pbaby88J
 eBq1d6as6h0pGO351r7455XjQTGfQxexFO+MFUVlFF+ju2/W8Vjgyorz/Ack1FrRqD8dvqdVK98
 sJGeycY2cGzbD19Pu4SVDvns=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id a2bb85ab9f24cd7b;
 Tue, 08 Sep 2026 14:25:16 +0000
X-Mizu-Trace-ID: a2bb85ab9f24cd7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <cbe03927-afdb-4558-9196-e57d899b8d01@linux.dev>
Date: Tue, 8 Sep 2026 22:24:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] drm/tyr: add BO-related ioctls
To: Daniel Almeida <daniel.almeida@collabora.com>, sunke@kylinos.cn
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-9-e0fdbf8bd108@kylinos.cn>
 <FDEDAB25-FBF2-438C-9C1C-F72DC851E88C@collabora.com>
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <FDEDAB25-FBF2-438C-9C1C-F72DC851E88C@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 9/5/26 04:35, Daniel Almeida wrote:
>
>> On 1 Sep 2026, at 13:09, Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org> wrote:
>>
>> From: Alvin Sun <alvin.sun@linux.dev>
>>
>> Expose buffer creation and BO mmap offset retrieval.
>>
>> - BO_CREATE page-aligns the size and returns a handle with
>>   write-combined mapping.
>> - BO_MMAP_OFFSET provides the offset for the DRM generic mmap
>>   path, rejecting NO_MMAP objects and non-zero pad.
>>
>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> Same comment as the previous patches, please write a few
> more things here about why the changes are needed.
>
> With that addressed,
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Hi Daniel,

Thanks for the review — your comments on patches 7 and 9 (the 
conditional Reviewed-bys) are addressed in v2:

https://lore.kernel.org/all/20260908-tyr-ioctls-v2-0-88bea777df67@kylinos.cn

Best regards,
Alvin


>
>> ---
>> drivers/gpu/drm/tyr/driver.rs |  2 ++
>> drivers/gpu/drm/tyr/file.rs   | 70 +++++++++++++++++++++++++++++++++++++++++++
>> drivers/gpu/drm/tyr/gem.rs    |  7 +++++
>> 3 files changed, 79 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
>> index b3145526ada06..fc8d11c9ba1ca 100644
>> --- a/drivers/gpu/drm/tyr/driver.rs
>> +++ b/drivers/gpu/drm/tyr/driver.rs
>> @@ -224,6 +224,8 @@ impl drm::Driver for TyrDrmDriver {
>>          (PANTHOR_VM_DESTROY, drm_panthor_vm_destroy, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_destroy),
>>          (PANTHOR_VM_BIND, drm_panthor_vm_bind, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_bind),
>>          (PANTHOR_VM_GET_STATE, drm_panthor_vm_get_state, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_get_state),
>> +        (PANTHOR_BO_CREATE, drm_panthor_bo_create, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_create),
>> +        (PANTHOR_BO_MMAP_OFFSET, drm_panthor_bo_mmap_offset, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_mmap_offset),
>>      }
>> }
>>
>> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
>> index 157bc40e1cac4..16abf2968299c 100644
>> --- a/drivers/gpu/drm/tyr/file.rs
>> +++ b/drivers/gpu/drm/tyr/file.rs
>> @@ -252,6 +252,76 @@ pub(crate) fn vm_get_state(
>>              Ok(0)
>>          })
>>      }
>> +
>> +    pub(crate) fn bo_create(
>> +        ddev: &TyrDrmDevice<Registered>,
>> +        _reg_data: &TyrDrmRegistrationData<'_>,
>> +        bocreate: &mut uapi::drm_panthor_bo_create,
>> +        file: &TyrDrmFile,
>> +    ) -> Result<u32> {
>> +        if bocreate.size == 0
>> +            || bocreate.pad != 0
>> +            || bocreate.flags & !uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0
>> +            || bocreate.exclusive_vm_id != 0
>> +        {
>> +            dev_err!(
>> +                ddev.as_ref(),
>> +                "Invalid BO_CREATE params: size={}, pad={}, flags={:#x}, exclusive_vm_id={}\n",
>> +                bocreate.size,
>> +                bocreate.pad,
>> +                bocreate.flags,
>> +                bocreate.exclusive_vm_id
>> +            );
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let size = usize::try_from(bocreate.size).map_err(|_| {
>> +            dev_err!(
>> +                ddev.as_ref(),
>> +                "BO_CREATE size {:#x} too large\n",
>> +                bocreate.size
>> +            );
>> +            EINVAL
>> +        })?;
>> +        let bo = crate::gem::new_object(ddev, size, bocreate.flags)?;
>> +        bocreate.handle = bo.create_handle(file)?;
>> +        bocreate.size = bo.size() as u64;
>> +
>> +        Ok(0)
>> +    }
>> +
>> +    pub(crate) fn bo_mmap_offset(
>> +        ddev: &TyrDrmDevice<Registered>,
>> +        _reg_data: &TyrDrmRegistrationData<'_>,
>> +        bommap: &mut uapi::drm_panthor_bo_mmap_offset,
>> +        file: &TyrDrmFile,
>> +    ) -> Result<u32> {
>> +        if bommap.pad != 0 {
>> +            dev_err!(
>> +                ddev.as_ref(),
>> +                "BO mmap offset pad not zero: {}\n",
>> +                bommap.pad
>> +            );
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        let bo = crate::gem::lookup_handle(file, bommap.handle).inspect_err(|_| {
>> +            dev_err!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", bommap.handle);
>> +        })?;
>> +        if bo.create_flags() & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0 {
>> +            dev_err!(ddev.as_ref(), "BO mmap offset on NO_MMAP object\n");
>> +            return Err(EPERM);
>> +        }
>> +        bommap.offset = bo.create_mmap_offset().inspect_err(|_| {
>> +            dev_err!(
>> +                ddev.as_ref(),
>> +                "Failed to create mmap offset for handle {}\n",
>> +                bommap.handle
>> +            );
>> +        })?;
>> +
>> +        Ok(0)
>> +    }
>> }
>>
>> fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> Result {
>> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
>> index d9ddcb287f52b..f404139f54f32 100644
>> --- a/drivers/gpu/drm/tyr/gem.rs
>> +++ b/drivers/gpu/drm/tyr/gem.rs
>> @@ -38,6 +38,13 @@ pub(crate) struct BoData {
>>      flags: u32,
>> }
>>
>> +impl BoData {
>> +    /// Returns the flags the BO was created with.
>> +    pub(crate) fn create_flags(&self) -> u32 {
> I would prefer flags() instead of create_flags(), which reads a bit more like a constructor.
>
>> +        self.flags
>> +    }
>> +}
>> +
>> /// Provides a way to pass arguments when creating BoData
>> /// as required by the gem::DriverObject trait.
>> pub(crate) struct BoCreateArgs {
>>
>> -- 
>> 2.43.0
>>
>>
>>
