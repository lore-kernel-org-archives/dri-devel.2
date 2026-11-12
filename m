Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992D606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BzCgs8nR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677B110E513;
	Thu, 12 Nov 2026 06:15:14 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D1010E510
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jz6QiNQHO7zwvFhUPkHykrebkpUkGOt6MOM6vSdSt30XDA64o4Bzb3UENQjPoFASWrdmPf7ec6lMZlmonLSUlFBYFP07WVGj0yh9oc8+JN0ywZZWywSJfGTGT73unAVGAoHhKviGBIPih7uS+8Nm7vUl98i26y783ADYpEvxirtCwDz4fxE6+MtOYX+88N/iZurr1FSscjugS1Hu6iyMpBMhnod1s6au84WHHlOrsw7izPysTghAwjYUiPGBrQa+5boRkXEOzPxuLx1+FTQuCnRUym9omCw8Uz3nVpnBy7pcUtHUGqAiNqxDk76iW6Km7Oo91lOfP6LE0gnNEYc1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfkK0R5L27ssqkuf12liv7EpX95OEEgLoyeJ8HnJ0+k=;
 b=SDvyIkx6YRzNco2RTVSLck6upwGJBEDeISTYRNPb3r+vGkel5F6pizNTwQFNoGyoIkEo2oW+GbMJsz8led3Kq/NsicSp78FLXovr3+PcxFl8SBTTIztXx3kq0mf7bsfThL/AWYUY/MpZPFf81ArBw9m1mA/aHMS18tOg3ElYItAC2LJwXRmxa3xBK38pADCFmeNSi42BdF1OyznIkpXb0aMPhO/roiK9Z92G4081tI90bsSWk714X/Rep0nfu0XEIv5SAdoMiVi3y+glNnusp2MzCr2soH/4KdMETvHoCCcnbo1pTYjewJ2kut/xpv5J3PtbapBjNLb9POG14hFjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfkK0R5L27ssqkuf12liv7EpX95OEEgLoyeJ8HnJ0+k=;
 b=BzCgs8nRFxr7dOPnwl6CqqSU346AdYap3JW371J0EfdkwH1YvBqpWL4To30XGe/1vsJ4qBGJT4TqooA7D+xH2q5LdJejFDvnspDIBsaUvMn67YK8jnAHXiZcB6OFFy1Nb0Vhku2rHLMBTPVQFurOy+N0YNu+8YaYyj1ztnzkhmbguvW+VWon9kDAYKg0gXCmO1FqRUHb/7Qtx4gXQ8UZzNj9MdDbRMVE3ct7BIAelBRywjAK+T+eAUSuKalSHIoGNgNv0YMJoParLRtZSDTOLq9XRoYlBbR2W75UhQiaUy7tTSk7yB+aGrygrKcdEog7MbhzmC8lq3Zp6HVnZqd7Bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 06:15:01 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 06:15:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 0/2] gpu: nova-core: gsp: fix misc cmdq issues
Date: Thu, 12 Nov 2026 15:14:52 +0900
Message-Id: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Oy26DMBREfwV5XVd+FIOzyn9UWfg+TFwJSGyCW
 kX8ex3oqsuRZs6cpyicExdxap4i85pKmqcazFsj8BqmgWWimoVRxmmtvBzLcJfuQ97CwEVCAGt
 QWXKmE3VzyxzT9877vBy5POCLcXlB/hqZ7496tBw1AaGwxHkc03JqOkbyzMbHDiKwD8Zb35oI2
 Fu0sQfqjGqJxIt+TWWZ888uv+oddnhq/c9z1VJJ6rF14CKRw/O0Jkrhvf6Ky7Ztv5CtkngJAQA
 A
X-Change-ID: 20261109-msgq-64-pages-bab32c03d627
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e22b742a-ec4d-42f9-46f2-08df40844861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|18002099003|11063799006|261022075727099003|261009223027099003|56012099006|261021123027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: pchw9UwRmlL9NJW55zKFdAiy5gv+3GRzWu4QCAtf8LtsrQaMBxHpTcZOpytYhfqACUk08xGhrMnhrrIfqP/s8otGjLPYeOgPb8+SrLNTec2gpzFK2xmNy2NztfL7e0TGdCnpGxbMY9D4SLJJcRY1XUnUkWP2WyaBtdPXlInQwFuAe6UIwqN1gqh+knxQ1xE/Fm6AYljqQomL1K5Q8ahgWgtgTdDsTHDchVXSKJaKgvXzfSEJ87JhLywiKYXFFYnRqcTiA0oBtDD814UkmMkNgUI6veaY8fdSIn2E0OrGkPfqdCZn1zv/2febeiQWYMpTNVeYN0ospYgW0dxydMtKWroNPD6ueqBS7JvMRhRN7UWEkmJd5RMDWvCpJEsUw9WDa/0PEkM7wg75k5UiX65eTimceWhHFgw873IEEGr3uMU/rxI8CtUU5L/lOt8rI1urbVfO6Qkimuc7SuIDQXdmh/GX7LNIBr4R6vn4iV4nL8yqQUmL77euWD8CR9Px+bhQYeJ6F6te4ytiWxBjzjbILSAvXBhz6J7QIFIYJHKVUq4hM+K3vPTQaROvTGp3ULVQp+D6XYc0rIcUHdS5gngOPGuZdwSfk6cmiRKsThYNv57BDNxshvj1mXaPTAZv35ohit/HW2WQSuiyyuCTBqRZqzIdUNiTklZ1l6KPaUPXeUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(18002099003)(11063799006)(261022075727099003)(261009223027099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG14aFhJdE9SVk1UUWpsWDA5TjVvY2MvQnNBWnd4M3Y2QkFyMzJyc20xelc1?=
 =?utf-8?B?ZS9SSnQxcmh5WExRL3pCSEpmZjZoRUQrNUVVcFI4QnY4ak1BUTFzOWp4U1F1?=
 =?utf-8?B?eFJrMmZGVUhYeGFyK2JvbDVKcktzQUVxZkVFZWFIVVEzbk93Ym9zSzFZKzdz?=
 =?utf-8?B?Nkp6RkN3MVlGUjZlc2ZjVTZvZGVUZnpLcVJlTVA5aVlSKzRhYk9UUGFxQ3la?=
 =?utf-8?B?ME1GUmhuTFZMK25wWCt4NEdrMTYwbjBlTnhuY2xwSENud2Zrd3luSFFIWWpm?=
 =?utf-8?B?OVRxZlRvL1lTWkdOenRJbXpjVXg4YlFyVCtkbnZxQTQrQmovRk05TjhBdlBH?=
 =?utf-8?B?K1hpSy9VeGloWXgyOHh4SEVnMmRpZnNDZ0dLZTNqcW4xMkl3amdFWkpZMmlQ?=
 =?utf-8?B?ZDVlL2JIVSt6azF2VjVFOHBhZk9XQStWQ2FrMnFHbTdKbXNSVHdUOVliT0JI?=
 =?utf-8?B?dXNSUnlyZ3Erb2JsbHFhbllIbnlML2w4QXdYQnZGbTJKSEExWGdRRVBjTHdr?=
 =?utf-8?B?VnFmcXl0NjVlZlZjUXRreGc3b2Y1RFRPbXFpWU9xd3ZwL1JxVEVWcnM0RFBi?=
 =?utf-8?B?WERDQnd2MWtoUCtMNyt3RGgvUkhEaGJoSzEzaTZBLzE1akNOZWMyNVZsaS9M?=
 =?utf-8?B?TzNNMkVrbllkVTdKbURPc1NVclJoVEZaWHJ1VitHZEtNVmZSckFTc2pOcThm?=
 =?utf-8?B?OHR6Zk5qcG5QUjZkdW9oRnpUQ2pmaTBzbjVBVGZrbWwrdEo4TWVITmQ5RG9T?=
 =?utf-8?B?S2dod3JxV3oxeGJTdjZPcjEvcVpKVGE0bkJmcFc5MzFtRGd5RkNxN2ZXT0hi?=
 =?utf-8?B?czk2ZlZXSVM1NVNzUGRmVmI3Z0xxc1JJaC9CYTdIMTdtRmlzb2VIOVoxYUtZ?=
 =?utf-8?B?MDFZeWpBT0FuR0NPYzE1TjVLQTE4aDYrYm1vaGY3UWhxa1RBOUl1Z1I0Slox?=
 =?utf-8?B?SUNZWnEya1FISW1RTFZIbG1zb2x5dTErUS9ndmZwWU9acUF2UzRZd0t3YkJM?=
 =?utf-8?B?b292Z3RmYUU4cVV2NG5WU0pwV0NscWxDT2ErNWh5RkRxY0w1cEhGZTRPSzVX?=
 =?utf-8?B?cFMxSlg4UGRmL3piWFVkTGZMd1Q1dGxWL2l5N25ZL1lVSXlJZHh2SVVmazNy?=
 =?utf-8?B?Qm1HRGtuUVo0TDhCQ3VuUlk4bzBkVXdlTytsUytFMlRvYmZENC8vbVpaVXlv?=
 =?utf-8?B?SFFob1ZBR09qMnhrY2YwSnNBSVE1NXJCcGxnaWhaR0ptQ1l3SWdLdy9JVldY?=
 =?utf-8?B?WjdQY3VxVlpwRnM0S1gyOVptKzVsUW0vMzFIVzRkYk1zVWpjeW9MdERsSy9C?=
 =?utf-8?B?cUtxeEJtL2ZmcmZ3d3psZVNNRm1jQ2QwS0NsOWpwUlRZY0RiQWdUemN4eW9B?=
 =?utf-8?B?TzFaa1BlRlNheEtkVldxeG5sN0ZEVGV3b1hWK2d0QlZ1Sk1hb09sdjZzL0g0?=
 =?utf-8?B?Wk4xTGY1SHk4SkEvNVhtbFM2OElxaHdBeGNWVlJKVWJkVHZaQnBmZjVEaGNW?=
 =?utf-8?B?NUZ2VzRpRVlEa0kxOExIbHRpQUY0V0pGOGpNbEE2eFhWY0NXb2liZUR5SUox?=
 =?utf-8?B?M2xuK1ZnS2hpejRSUkxQNnZIWmJ2dm1nb0dyVFVLZG5Dci9oQkFKcW95RXMz?=
 =?utf-8?B?UWV4L3V5OFpyYWRUeDNHWTdzUlZkUUZPN1JTbVZqeUlYVHJFTXB1UlJ5eit2?=
 =?utf-8?B?UkdTd2Q3c1hSSTNha05reGJwQ3laQVN2YmxrbDhMQ1BhTjlmbGJ1TXZqNmVx?=
 =?utf-8?B?MXdaRjJCaEVxeHpzUFpwSmR4N2N0YUg3M0F5RC91eGlhZUM2Y0pEcG1hQzBm?=
 =?utf-8?B?QmU1UnFLRVV2NllWcFBsZWx3L2cyMHBWSTcxclZLNUMrY0x4WC80K08wclZ0?=
 =?utf-8?B?R3B3SGtFa2tuY2pMSWpsZGUvQlRwWkEvOVJxZUpqdFZSV2llRGdEUmszKzk2?=
 =?utf-8?B?UVhBWVlQNzdqelBuWm1VRTIybFNvbUV1OTZ3SlJMWVlUK3d1L1FzRFdlQUFn?=
 =?utf-8?B?NlRVcFFKQ25raXdjMURwSDJNQnZ3U1BZc2VZUk9oSmduYXFaaUpOQ3J5TVln?=
 =?utf-8?B?S2hrajJtVUhjdjlKdW9mdlNqUkQ1WDgrV0dUWGlSdlRXclBRUGwzbzZHeDdE?=
 =?utf-8?B?RlM2cW1HRVRUcHJuZUhXTWVMblpmdmFzWnZrUkpJTzhwSUZ1V2d5cy9EL2pH?=
 =?utf-8?B?RTV1clU3cTZNOUJWTk96U2lnOUdSRUFscWpsb0t4TW9pcDM0Q3lORCtndWFy?=
 =?utf-8?B?OXdVVDN5bzVFd3RHZENVM1ByUldhbmJlMXZLZnhTV0hmNGtudGVlamJ3TGJH?=
 =?utf-8?B?MHdLaWhEOUg3cUJQeVFYU21CSjNWMEYvMXU2OXBIV010NDEvOElCQ1hmSjM2?=
 =?utf-8?Q?k9RQphCZLz/bwR8I/LMEUUGV/TEqCYllQjNpqOCa1bUXd?=
X-MS-Exchange-AntiSpam-MessageData-1: DJliZnM69uhmPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22b742a-ec4d-42f9-46f2-08df40844861
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:15:00.6899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq7xmRURat9oSmd5P/Hrsr9rAlxQZiI6VlqMzeeWWSyvZADN3n0EJaiHyygNYaV2phI9S0JR2h175KDDaeFgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix two cmdq issues.

This is based on drm-rust-next.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v2:

- Simplify the comment in patch #2 and check that `MSGQ_NUM_PAGES`
  divides `1 << 32` (Alex). I used `%` since `is_multiple_of()` is out
  due to MSRV.
- Add reviewed-by tags
- Link to v1: https://patch.msgid.link/20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com

---
Eliot Courtney (2):
      gpu: nova-core: gsp: cmdq: wrap the sequence number on overflow
      gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES to 64

 drivers/gpu/nova-core/gsp/cmdq.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 7ecd9ee29f7bfbe9a293952fbc83c3f8bd7205dd
change-id: 20261109-msgq-64-pages-bab32c03d627

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

