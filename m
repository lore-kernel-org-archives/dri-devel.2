Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30BFC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB0E10EE92;
	Thu, 30 Jul 2026 10:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfvwoF0g";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9345A10EE92
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:41:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956242332dso16932495e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785408087; x=1786012887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOL9N86L1OioG/3DjR3pD+pVPyZKRK8hcf21uMcbnBc=;
 b=nfvwoF0grwFqOeYZQXEN8UxvZOnBV1vdLM4wfw07lyyU6qS0EebbHfqyOnhioHSHF1
 jnxGntIo+UgkI0KEwSvWuIG0wffJ6hrXZ2tBpIDMgQQWExE/5zdhEk86e5tVvmfG7tqZ
 6BoRaUZAcw6c1hZLd+nOMvlQhKije03VgOfGz8y5PJ0t2K0SVzgZEvSe46IoraMoCTU7
 cPLol5TlYC/Yly3I/sb8NP1DmHS5mhfyuNKEZTHBTpg1/aNDOzujxIsYPsnMRGRVSTpY
 tKcjXE9MW09iRDl+ZuW70P5k3BYlrl9sDiLLxrD78FtT4KRg40FfWeAQzAQGAkpjgA8B
 x/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785408087; x=1786012887;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOL9N86L1OioG/3DjR3pD+pVPyZKRK8hcf21uMcbnBc=;
 b=qWE4Vk0OXOZuoesLrg2oGulXZGp6mGbYLtfUaI2JH4+AcFXVOVLjMsL5opMV2wRHUG
 aa1iEfm+s08i3JlzmNThWLNRld6f3zCQ/dbuiuMTGdVgaBZI7FjbiH6HHlNV61grs+Rt
 iBpOwot2DXGEDcZA8prKYulxZdW2jQnnTzIVNw0/bwrtdhSre4mwHBl4+M4GnqEQrA5Z
 6xXCDvqjfFoAr57/nDE2grkSlxKG9ChgusGAkr5QC16E/ebv9A0mf/A4M6uYlTy3w1ZN
 55mWT5LxlwdzIw48FyC5LBwO//rniWRT0pPzqXhC7yjDsDGjIjeR3uZIRhqxhctBiHIG
 NSWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQOcBXIQ72lgqIlPDRPcx7VndXLtOOT8KFRLOVN2w7g3ZtfhM8Cuil21GsK00xsFxfPCj6qacRdpo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpbED7WnvQ5LQw6CQZedZx/E//dRrTLWlAlnb2oISE/ISz42JH
 S440AFWpG4tHcqZccYUfSYujslkm+fO9iojgEEDiPY8JgAL9vZszwvIH
X-Gm-Gg: AR+sD10IvuKVqcRJaNwA1XtBmVzM6XY0qHITl2V7KKDv2JV5awyhKGoDwgpR1WEp2Ex
 oJFq3bAq5QSaCrEKrjE5F3dDcGj8FkVp41mb7g4bYVz3Ix0Oq1v2mST0hU4rfqIKFdKhhXjBzJo
 IVII0LkEyyR4LThaMrtG8Hf4PSrNGai0TD2E2+vn1c54mnKk2qCFtxC2rmBhXOa8akBXDDlyv4B
 LUoH7CPC86dTdKyY/CfBjjvJgD3IpbjeOo7XzPcMIw6Bh4pHkU2msjZdjtl+E/h6uMmY5oKCsnb
 xWFR/ENeYd8e79oxZUClmWiaWiiqiyjfT/KSaaCD8rty3PKPblm2vrZ6Cw2Wn7dBwrN876Dq7L8
 SRTQl84YaMRRKzvvY0QHFxQex5x2Xf/l5r79kSq2OXMPVmz9fHAfGTeIeNBT+Z9ZUmqEo8vynKa
 51KJpkVgH4ns8Q/F184JA9E8YZQ0mW1oDZhPzctJCLHhhVVsQResDwtKkNOBWp7yXnyU0ZncPrC
 9kWBWwN/a4hI3jGjFKu7UdgUVaNICglV+qpczApsErSHSIsSaUAgIWE5S991sPy2QqpxINgbKtm
 31q3t8vHW+QG8aNEewI6
X-Received: by 2002:a05:600c:c494:b0:495:745e:7430 with SMTP id
 5b1f17b1804b1-49800ea99fdmr23256155e9.20.1785408086793; 
 Thu, 30 Jul 2026 03:41:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:2f22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89347bfsm4376944f8f.28.2026.07.30.03.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 03:41:25 -0700 (PDT)
Message-ID: <de4ec386-42ba-41c3-bcbe-1fe8b2f71ba9@gmail.com>
Date: Thu, 30 Jul 2026 11:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
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

On 7/29/26 20:43, Caleb Sander Mateos wrote:
> On Tue, Jul 28, 2026 at 2:35 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
>> dmabuf when it's mapped, which is then used to initialise requests.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   drivers/nvme/host/core.c |  12 ++
>>   drivers/nvme/host/nvme.h |   2 +
>>   drivers/nvme/host/pci.c  | 259 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 273 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 453c1f0b2dd0..ce66a1843bec 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2676,6 +2676,17 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
>>   #define nvme_report_zones      NULL
>>   #endif /* CONFIG_BLK_DEV_ZONED */
>>
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +                                   struct dma_buf_io_ctx *ctx)
>> +{
>> +       struct nvme_ns *ns = bdev->bd_disk->private_data;
>> +       struct nvme_ctrl *ctrl = ns->ctrl;
>> +
>> +       if (!ctrl->ops->init_dma_buf_io_ctx)
>> +               return -EINVAL;
>> +       return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
>> +}
>> +
>>   const struct block_device_operations nvme_bdev_ops = {
>>          .owner          = THIS_MODULE,
>>          .ioctl          = nvme_ioctl,
>> @@ -2686,6 +2697,7 @@ const struct block_device_operations nvme_bdev_ops = {
>>          .get_unique_id  = nvme_get_unique_id,
>>          .report_zones   = nvme_report_zones,
>>          .pr_ops         = &nvme_pr_ops,
>> +       .init_dma_buf_io_ctx = nvme_init_dma_buf_io_ctx,
>>   };
>>
>>   static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 824651cc898d..034c31af8fec 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -652,6 +652,8 @@ struct nvme_ctrl_ops {
>>          int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>>          void (*print_device_info)(struct nvme_ctrl *ctrl);
>>          bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>> +       int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
>> +                                  struct dma_buf_io_ctx *ctx);
>>          unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
>>   };
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 69932d640b53..f1b67c191892 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -27,6 +27,8 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/io-64-nonatomic-hi-lo.h>
>>   #include <linux/sed-opal.h>
>> +#include <linux/dma-buf-io.h>
>> +#include <linux/dma-resv.h>
>>
>>   #include "trace.h"
>>   #include "nvme.h"
>> @@ -393,6 +395,13 @@ struct nvme_queue {
>>          struct completion delete_done;
>>   };
>>
>> +struct nvme_dmabuf_map {
>> +       struct dma_buf_io_map base;
>> +       struct sg_table *sgt;
>> +       unsigned nr_entries;
>> +       dma_addr_t dma_list[];
>> +};
>> +
>>   /* bits for iod->flags */
>>   enum nvme_iod_flags {
>>          /* this command has been aborted by the timeout handler */
>> @@ -859,6 +868,138 @@ static void nvme_free_descriptors(struct request *req)
>>          }
>>   }
>>
>> +static inline struct nvme_dmabuf_map *
>> +to_nvme_dmabuf_map(struct dma_buf_io_map *map)
>> +{
>> +       return container_of(map, struct nvme_dmabuf_map, base);
>> +}
>> +
>> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
>> +                                        struct request *req)
>> +{
>> +       struct device *dev = nvme_dev->dev;
>> +       enum dma_data_direction dma_dir;
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       unsigned offset = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +       int length = blk_rq_payload_bytes(req) +
>> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
>> +
>> +       dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +
>> +       while (length > 0) {
>> +               dma_sync_single_for_cpu(dev, dma_list[map_idx++],
>> +                                       NVME_CTRL_PAGE_SIZE, dma_dir);
>> +               length -= NVME_CTRL_PAGE_SIZE;
>> +       }
>> +}
>> +
>> +static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
>> +                                           struct request *req)
>> +{
>> +       struct device *dev = nvme_dev->dev;
>> +       enum dma_data_direction dma_dir;
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       unsigned offset = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +       int length = blk_rq_payload_bytes(req) +
>> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
>> +
>> +       dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +
>> +       while (length > 0) {
>> +               dma_sync_single_for_device(dev, dma_list[map_idx++],
>> +                                          NVME_CTRL_PAGE_SIZE, dma_dir);
>> +               length -= NVME_CTRL_PAGE_SIZE;
>> +       }
>> +}
>> +
>> +static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
>> +                                     struct request *req)
>> +{
>> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +       nvme_dmabuf_map_sync_for_cpu(dev, req);
>> +
>> +       if (!(iod->flags & IOD_SINGLE_SEGMENT))
>> +               nvme_free_descriptors(req);
>> +}
>> +
>> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
>> +                                            struct nvme_queue *nvmeq)
>> +{
>> +       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +       struct bio *bio = req->bio;
>> +       struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +       unsigned bvec_done = bio->bi_iter.bi_offset;
>> +       unsigned map_idx = bvec_done / NVME_CTRL_PAGE_SIZE;
>> +       unsigned offset = bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
>> +       int length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
>> +       dma_addr_t *dma_list = map->dma_list;
>> +       u64 prp1_dma = dma_list[map_idx++] + offset;
>> +       u64 dma_addr, prp2_dma;
>> +       dma_addr_t prp_dma;
>> +       __le64 *prp_list;
>> +       unsigned i;
>> +
>> +       nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
>> +
>> +       if (length <= 0) {
>> +               prp2_dma = 0;
>> +               goto done;
>> +       }
>> +
>> +       if (length <= NVME_CTRL_PAGE_SIZE) {
>> +               prp2_dma = dma_list[map_idx];
>> +               goto done;
>> +       }
>> +
>> +       if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
>> +           NVME_SMALL_POOL_SIZE / sizeof(__le64))
>> +               iod->flags |= IOD_SMALL_DESCRIPTOR;
>> +
>> +       prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>> +                       &prp_dma);
> 
> I wonder if it's possible to perform the PRP list page allocations and
> initialization in nvme_dma_buf_io_map() instead of the I/O path. The
> NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
> making them significant CPU hotspots. If the dmabuf registration set
> up a contiguous DMA-coherent list of PRP entries for the pages of the
> registered buffer, any command using the dmabuf and requiring at most
> 1 PRP list page (i.e. length <= 2 MB) could just set its PRP list
> pointer to an offset into the dmabuf's PRP list.

Possible to an extent, predecessor patches tried that, I left it for
later to keep the series simpler. I guess chaining won't work in
general case.
I mentioned this to Kanchan, Anuj and Nitesh before, they were up to
playing with nvme optimisations in general, and since sgl from Anuj
is ready, maybe they already have a prototype somewhere for that.

-- 
Pavel Begunkov

