Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D0C88E42
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D5F10F401;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9151210E08B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 03:58:13 +0000 (UTC)
X-UUID: d424ba0eaccb11f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:783a6890-3efb-439e-bcd4-658632ac3b45, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:d8f48e63ea9b832664a29e31d998231e,
 BulkI
 D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
 EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d424ba0eaccb11f19a56ed5b684f684d-20260910
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 1146476214; Thu, 10 Sep 2026 11:58:06 +0800
Message-ID: <9447bb67-96e9-43b3-87c8-db231051fa2d@kylinos.cn>
Date: Thu, 10 Sep 2026 11:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
 <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
 <2026090924-corsage-shout-833d@gregkh>
 <33c9db65-fa30-4d34-9026-98144ce1ed95@amd.com>
Content-Language: en-GB
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <33c9db65-fa30-4d34-9026-98144ce1ed95@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

Hi Christian,

>>>> Nor why "fgds" is the name, that's going to be hard to remember, does it
>>>> stand for something?
>>>>
>>> "FGDS" stands for Fast GPUDirect Storage. GPUDirect Storage (GDS) is NVIDIA's 
>>> technology enabling direct I/O between GPU memory and files on NVMe, 
>>> widely used in LLM workloads to bypass CPU overhead.
>>
>> That's nvidia's specific solution, but this works on other devices,
>> right?  Or just for that one platform?
> 
> That was nvidia's specific and very hacky out of tree solution 
Exactly, I completely agree with your viewpoint. In fact, we previously conducted 
a deep analysis of NVIDIA's GDS implementation code, which was also one of the 
motivations for us to develop fgds.

Please allow me to introduce NVIDIA's GDS implementation briefly:
NVIDIA introduced two kernel modules: one module called nvidia-fs, and the other module 
is a customized NVMe driver replacing the Linux kernel's default NVMe driver. 
nvidia-fs creates a device file for every NVIDIA GPU on the machine: /dev/nvidia-fs<gpu-id>.

Applications call cuFileBufRegister to register the GPU memory buffer to perform I/O. 
cuFileBufRegister executes the following operations: calls nvidia-fs via ioctl. The 
implementation of this ioctl allocates a corresponding phony buffer of the same size 
in the host memory, and establishes a mapping between the CPU memory phony buffer 
and the GPU memory buffer.

Then, the application calls cuFileRead/cuFileWrite to perform file I/O operations. 
Its implementation calls ioctl on nvidia-fs with NVFS_IOCTL_READ/NVFS_IOCTL_WRITE 
as parameters. Inside the ioctl implementation, it calls the common kernel interface 
filp->f_op->read_iter/write_iter() on the file on NVME. These interfaces can only take 
the CPU memory phony buffer address as a input, constructing read/write requests sent 
through the block layer to the customized NVMe driver.

The customized NVMe driver intercepts the I/O operations, calls the nvidia-fs interface to 
query, replaces the phony buffer address with the GPU memory dma address, and performs 
DMA transfer between GPU memory and NVMe.

As we can see, this implementation is indeed very hacky and non-elegant. Furthermore, 
as evaluated in this paper published in SC'25 [1], the phony buffer brings a considerable 
performance overhead.

> which as far as I know is pretty much abandoned everywhere.
However, despite the overhead of phony buffers, GDS performance is still significantly higher 
than transferring through CPU host memory (as shown in our performance benchmark tests [2]). 
Therefore, GDS is actually still widely used in the LLM ecosystem. For instance, model loading 
plugins used in inference engines like vLLM and SGLang—such as fastsafetensors and InstantTensor—
both support acceleration via GDS [3,4], with fastsafetensors enabling GDS by default for model loading. 
Furthermore, LMCache, a plugin used for KV cache offloading in vLLM and SGLang, also supports 
GDS acceleration [5]. PyTorch itself also provides file access APIs based on GDS [6].

> 
> AMD came up with something similar, but all those approaches are so fundamentally broken that we didn't even considered upstreaming it.
>> And you are using this as a "bypass" for the normal accel subsystem,
>> shouldn't this be part of that subsystem instead of a custom user/kernel
>> api like you are creating here?
> 
> As far as I know there is a patch set under review and even already partially merged which enables exactly that functionality as general feature for DMA-buf which is vendor independent and should at least in theory work with all drivers.
> 
> I'm really surprised that somebody is still working on the vendor specific stuff.
As you pointed out, every vendor has been inventing their own way and interfaces to support GDS, 
introducing custom kernel modules and proprietary UAPI interfaces, with varying performance that 
leaves developers heavily frustrated. Apologies for not making this clear enough in our commit 
messages, which understandably caused some confusion. We merely borrowed the name "GDS" to describe 
the functional purpose of fgds.

In fact, we believe fgds offers four key advantages: 
(1) GPU platform independence; 
(2) POSIX/io_uring interface compatibility;
(3) Higher performance than GDS;
(4) Minimal kernel footprint and UAPI footprint

Regarding (1), (2), and (3), please allow me to briefly explain the design mechanism of fgds:
fgds turns a GPU memory buffer into a POSIX/io_uring-compatible user-space virtual address via 
three main steps:

Step 1: Utilizing ZONE_DEVICE support, we remap the GPU memory exposed via PCIe BAR into struct pages 
using devm_memremap_pages();

Step 2: Utilizing dma-buf support, the GPU memory buffer is exported as a dma-buf file descriptor (fd). 
Using this fd as a bridge, we look up the corresponding DMA addresses for the GPU memory buffer inside 
the kernel;

Step 3: Through mmap, we insert the struct pages corresponding to the GPU memory buffer into the userspace 
VMA, mapping their physical/DMA addresses directly. The virtual address returned by mmap can then be directly 
passed into standard POSIX or io_uring interfaces.

As you can see, since almost all major GPU vendors support exporting GPU memory buffers via dma-buf, 
all remaining technical dependencies of fgds rely on standard Linux kernel infrastructure. Therefore, 
fgds is completely vendor-agnostic and natively compatible with POSIX/io_uring without introducing any proprietary 
vendor interfaces, which greatly simplifies development, deployment, operations and unifies standard usage. 
Furthermore, because this technique completely eliminates the phony buffer, its performance is significantly 
better than NVIDIA's GDS (as shown in our benchmarks [2]).

In addition, since fgds uses only the most fundamental dma-buf mechanisms, it relies on baseline dma-buf features 
that have been supported in the upstream kernel for a long time, rather than any new dma-buf features currently 
under active development. In fact, before we recently ported fgds to the latest kernel tree, it was developed 
and ran on our internal 6.6 kernel. It has been running stably in our production clusters for over half a year 
across various hardware platforms (including NVIDIA, AMD, and several other vendors) without requiring a single 
line of GPU-platform-specific fgds code modification.

Regarding (4): We believe that implementing GDS-like functionality inherently requires kernel assistance to map 
the GPU memory buffer to a valid userspace virtual address. This inevitably requires userspace-kernel interaction. 
To the best of our knowledge, the mainline kernel currently lacks a dedicated, unified path for this specific interaction, 
which is why various vendors ended up writing their own out-of-tree interfaces. In contrast, fgds introduces 
only one single new ioctl parameter (REG_BUFFER, excluding UNREG_BUFFER), and confines its scope strictly to a 
standalone device driver. We believe this achieves a minimal kernel footprint and minimal UAPI addition.

[1] https://dl.acm.org/doi/10.1145/3712285.3759862
[2] https://github.com/Storage-and-OS-for-AI/fgds
[3] https://github.com/foundation-model-stack/fastsafetensors/blob/main/docs/configuration.md
[4] https://github.com/scitix/InstantTensor/blob/main/csrc/loader_io_cufile.cpp
[5] https://github.com/LMCache/LMCache/blob/dev/lmcache/v1/storage_backend/gds_backend.py
[6] https://docs.pytorch.org/docs/2.14/generated/torch.cuda.gds.GdsFile.html

Thanks,
Li Wang> Regards,
> Christian.
> 
>>
>> thanks,
>>
>> greg k-h

